export type FriendLink = {
	name: string;
	url: string;
	description: string;
	/** Use an https URL or a path under /public, such as /friends/alice.webp. */
	avatar?: string;
};

export const friendLinks: FriendLink[] = [
	// Add a friend by copying this example and removing the leading // markers:
	{
		name: "Shiori",
		url: "https://sh10rl.top/",
		description: "Shiori's Coffee Nook",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/Shiori.b8bfe4e0.png",
	},
	{
		name: "z221x",
		url: "https://www.z221x.website/",
		description: "z221x-Blog",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/z221x.dc1d32d8.png",
	},
	{
		name: "Rencj",
		url: "https://blog.rencj.top/",
		description: "Rencj’s Blog",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/Rencj.c97c04fd.jpg",
	},
	{
		name: "ScaredCube",
		url: "https://sccube.link/",
		description: "ScaredCube’s Site",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/scaredcube.23d87dc5.jpg",
	},
	{
		name: "NaCl",
		url: "https://blog.naclwww.com/",
		description: "NaCl Blog",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/NaCl.347873a7.png",
	},
	{
		name: "woshiluo",
		url: "https://woshiluo.com/",
		description: "Woshiluo's Notebook",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/woshiluo.32aef4b1.png",
	},
	{
		name: "柏喵Sakura",
		url: "https://baimeow.cn/",
		description: "bs’ realm",
		avatar:
			"https://thirdqq.qlogo.cn/g?b=sdk&k=NWicTpzaicZibPBH6DibfBnogQ&kti=ZI090wAAAAA&s=640",
	},
	{
		name: "JYC",
		url: "https://www.jyc217.com/",
		description: "一个人的碎碎念",
		avatar: "https://www.jyc217.com/assets/Sauroncat-CZ7otR4q.jpg",
	},
	{
		name: "wuliwa",
		url: "https://wuli-wa.github.io/",
		description: "wuli-wa?",
		avatar:
			"https://vidar.club/assets/images/src/images/avatar/wuliwa.23b692a6.jpg",
	},
];
