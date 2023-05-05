var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

Page({
  /**
   * 页面的初始数据
   */
  data: {
    sellerUserName: "", //商家账号
    password: "", //预留密码段
    sellerName: "", //商户名称
    sellerPhotoUrl: "", //商户照片
    workContent: "", //经营内容
    workTime: "", //经营时间
    telephone: "", //联系电话
    workAddress: "", //工作地址
    workLicenseUrl: "", //营业许可证
    scoreValue: "", //评价分数
    shenHeState: "", //审核状态
    addTime: "", //注册时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (params) {
    var self = this
    var sellerUserName = params.sellerUserName
    var url = config.basePath + "api/seller/get/" + sellerUserName
    utils.sendRequest(url, {}, function (sellerRes) {
      wx.stopPullDownRefresh()
      self.setData({
        sellerUserName: sellerRes.data.sellerUserName,
        password: sellerRes.data.password,
        sellerName: sellerRes.data.sellerName,
        sellerPhoto: sellerRes.data.sellerPhoto,
        sellerPhotoUrl: sellerRes.data.sellerPhotoUrl,
        workContent: sellerRes.data.workContent,
        workTime: sellerRes.data.workTime,
        telephone: sellerRes.data.telephone,
        workAddress: sellerRes.data.workAddress,
        workLicense: sellerRes.data.workLicense,
        workLicenseUrl: sellerRes.data.workLicenseUrl,
        scoreValue: sellerRes.data.scoreValue,
        shenHeState: sellerRes.data.shenHeState,
        addTime: sellerRes.data.addTime,
      })
    })
  },

  lookEvaluate: function(){
    var self = this
    wx.navigateTo({
      url: '../evaluate/evaluate_seller?sellerUserName=' + self.data.sellerUserName ,
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

