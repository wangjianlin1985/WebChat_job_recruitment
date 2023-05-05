var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    evaluateId: 0, //评价id
    sellerObj: "", //被评价商家
    evaluateScore: "", //评分
    evaluateContent: "", //评价内容
    userObj: "", //评论用户
    evaluateTime: "", //评价时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var evaluateId = params.evaluateId
    var url = config.basePath + "api/evaluate/get/" + evaluateId
    utils.sendRequest(url, {}, function (evaluateRes) {
      wx.stopPullDownRefresh()
      self.setData({
        evaluateId: evaluateRes.data.evaluateId,
        sellerObj: evaluateRes.data.sellerObj.sellerName,
        evaluateScore: evaluateRes.data.evaluateScore,
        evaluateContent: evaluateRes.data.evaluateContent,
        userObj: evaluateRes.data.userObj.name,
        evaluateTime: evaluateRes.data.evaluateTime,
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  }

})

