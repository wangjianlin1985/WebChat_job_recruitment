var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    evaluateId: 0, //评价id
    sellerObj_Index: "0", //被评价商家
    sellers: [],
    evaluateScore: "", //评分
    evaluateContent: "", //评价内容
    userObj_Index: "0", //评论用户
    userInfos: [],
    evaluateTime: "", //评价时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //初始化下拉框的信息
  init_select_params: function (options) { 
    var self = this;
    var url = null;
    url = config.basePath + "api/seller/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        sellers: res.data,
      });
    });
    url = config.basePath + "api/userInfo/listAll";
    utils.sendRequest(url, null, function (res) {
      wx.stopPullDownRefresh();
      self.setData({
        userInfos: res.data,
      });
    });
  },
  //被评价商家改变事件
  bind_sellerObj_change: function (e) {
    this.setData({
      sellerObj_Index: e.detail.value
    })
  },

  //评论用户改变事件
  bind_userObj_change: function (e) {
    this.setData({
      userObj_Index: e.detail.value
    })
  },

  /*提交添加商家评价到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/evaluate/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        evaluateId: 0,
        sellerObj_Index: "0",
    evaluateScore: "",
    evaluateContent: "",
        userObj_Index: "0",
    evaluateTime: "",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
    });
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.init_select_params(options);
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    var token = wx.getStorageSync('authToken');
    if (!token) {
      wx.navigateTo({
        url: '../mobile/mobile',
      })
    }
  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {
  }
})

