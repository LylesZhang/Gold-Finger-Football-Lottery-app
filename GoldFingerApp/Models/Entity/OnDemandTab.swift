struct OnDemandTab: Identifiable {
    let id: String
    let name: String
    let newsId: Int
}

let onDemandTabs: [OnDemandTab] = [
    OnDemandTab(id: "tab01", name: "中奖喜报",    newsId: 321),
    OnDemandTab(id: "tab02", name: "金手指头条",  newsId: 322),
    OnDemandTab(id: "tab03", name: "精品推荐",    newsId: 196),
    OnDemandTab(id: "tab04", name: "足彩单场",    newsId: 197),
    OnDemandTab(id: "tab05", name: "足彩专区",    newsId: 134),
    OnDemandTab(id: "tab06", name: "竞彩及过关串", newsId: 276),
    OnDemandTab(id: "tab07", name: "特色足彩",    newsId: 189),
    OnDemandTab(id: "tab08", name: "竞彩体验",    newsId: 0)
]
