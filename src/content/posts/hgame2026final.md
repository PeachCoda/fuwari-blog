---
title: "Hgame Final 2026"
published: 2026-04-12T02:57:18+08:00
category: "CTF"
tags:
  - "wp"
  - "VM"
  - "花指令"
draft: false
lang: "zh_CN"
---
> https://hgame.vidar.club/games/10

<!-- more -->

## juncrypt

> 汇编，好看爱看

main有一段诡异的逻辑

```c
  v4 = sub_12B0(s_1, _r_n);
  if ( v4 < 0 )
  {
    puts("runtime error");
    return 1;
  }
  Wrong = "Wrong";
  if ( v4 )
    Wrong = "Correct";
  puts(Wrong);  
```

在sub_12B0函数的最后有

```c
    munmap(addr_1, 0x2DAu);
  }
  return 0xFFFFFFFFLL;
}
```

`v4 < 0`恒成立，`Wrong = 'Correct'`不可能执行

所以真正的校验没有在pseudocode里体现

sub_12B0调用sub_1260完成了对shellcode的加载，存入mmap申请的内存

只要获得shellcode，就能恢复校验逻辑

因为地址的动态性，只能下断点在转移控制流的位置dump shellcode

看一下`mprotect`附近的汇编

```asm
.text:0000000000001394 push    rax
.text:0000000000001395 mov     rax, rbx
.text:0000000000001398 jmp     short loc_13A2

.text:00000000000013A2 push    rax ; 把 Shellcode 的动态地址压入栈顶
.text:00000000000013A3 retn
```

断在loc_13A2即可

```
set disable-randomization on
starti

b *0x5555555553a2

commands
    dump binary memory shellcode.bin $rax $rax+0x2da
    quit
end
continue
```

dump下`shellcode.bin`，拖进ida恢复函数

是一个自定义加密逻辑，解密逻辑为

```c
ROL1( ROL1(v, s1) ^ flag_char ^ c, s2 ) == t
=> ROL1(v, s1) ^ flag_char ^ c == ROR1(t, s2)
=> flag_char == ROL1(v, s1) ^ c ^ ROR1(t, s2)
```

```python
def ror1(val, shift):
    return ((val & 0xFF) >> shift) | ((val << (8 - shift)) & 0xFF)

def rol1(val, shift):
    return (((val & 0xFF) << shift) & 0xFF) | ((val & 0xFF) >> (8 - shift))

def ror4(val, shift):
    return ((val & 0xFFFFFFFF) >> shift) | ((val << (32 - shift)) & 0xFFFFFFFF)

def rol4(val, shift):
    return (((val & 0xFFFFFFFF) << shift) & 0xFFFFFFFF) | ((val & 0xFFFFFFFF) >> (32 - shift))

a2 = 27
v = rol4(a2, 3)

targets = [
    7, 0x9A, 0xCC, 75, 0x80, 6, 0x97, 38, 44, 95,
    119, 44, 0x95, 0xE4, 0, 34, 109, 8, 0x97, 91,
    0xE7, 0xDD, 55, 50, 0x8B, 1, 0x8E
]

c_vals = [(0x5A + i * 0x0D) & 0xFF for i in range(27)]

shift1_pattern = [1, 2, 3, 4, 5]
shift2_pattern = [1, 2, 3, 4, 5, 6, 7]

flag = []

for i in range(27):
    s1 = shift1_pattern[i % 5]
    s2 = shift2_pattern[i % 7]
    c = c_vals[i]
    t = targets[i]

    part1 = rol1(v & 0xFF, s1)
    part2 = ror1(t, s2)

    char_code = part1 ^ c ^ part2
    flag.append(chr(char_code))

    v = (ror4(v, 1) + 61) & 0xFFFFFFFF

print(''.join(flag))
# hgame{junk_asm_and_selfdec}
```

## ez_drv

> VM + AES + XOR

ida分析 `vuln.sys`

VM解释器：`sub_14000219C`，字节码：`qword_140004230`

AES加密：`sub_140001210`，S-box：`RijnDael_AES_LONG_140004300`

AES密文：`xmmword_140004210` 、`xmmword_140004220` 

逆字节码发现在AES后还有一个XOR处理，XOR key：`byte_140004410`

```python
from Crypto.Cipher import AES
from itertools import cycle

key = b"EzDrvK3y!@#$%^&*"
xor = [0xde, 0xad, 0xbe, 0xef, 0xca, 0xfe, 0xba, 0xbe]

aes_encrypted = [
    0x32, 0x9a, 0xb6, 0xc, 0x79, 0xf, 0x3b, 0x33,
    0x7, 0x4c, 0x8b, 0x55, 0x96, 0x7c, 0xad, 0x25,
    0x8c, 0x9d, 0xdc, 0x5a, 0xf7, 0xe7, 0x61, 0xf2,
    0xaf, 0x8e, 0x57, 0xfa, 0xa7, 0x4c, 0x25, 0xa
]

ciphertext = bytes([a ^ b for a, b in zip(aes_encrypted, cycle(xor))])
cipher = AES.new(key, AES.MODE_ECB)
flag = cipher.decrypt(ciphertext)

print(flag)
# hgame{vM_AES_XoR_r1ng0_noDbg}
```
