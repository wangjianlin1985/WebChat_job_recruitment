var utils = require("../../utils/common.js")
var config = require("../../utils/config.js")

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

  //被评价商家修改事件
  bind_sellerObj_change: function (e) {
    this.setData({
      sellerObj_Index: e.detail.value
    })
  },

  //评论用户修改事件
  bind_userObj_change: function (e) {
    this.setData({
      userObj_Index: e.detail.value
    })
  },

  //提交服务器修改商家评价信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/evaluate/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var evaluatelist_page = pages[pages.length - 2];
      var evaluates = evaluatelist_page.data.evaluates
      for(var i=0;i<evaluates.length;i++) {
        if(evaluates[i].evaluateId == res.data.evaluateId) {
          evaluates[i] = res.data
          break
        }
      }
      evaluatelist_page.setData({evaluates:evaluates})
      setTimeout(function () {
        wx.navigateBack({})
      }, 500) 
    })
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
        sellerObj_Index: 1,
        evaluateScore: evaluateRes.data.evaluateScore,
        evaluateContent: evaluateRes.data.evaluateContent,
        userObj_Index: 1,
        evaluateTime: evaluateRes.data.evaluateTime,
      })

      var sellerUrl = config.basePath + "api/seller/listAll" 
      utils.sendRequest(sellerUrl, null, function (res) {
        wx.stopPullDownRefresh()
        self.setData({
          sellers: res.data,
        })
        for (var i = 0; i < self.data.sellers.length; i++) {
          if (evaluateRes.data.sellerObj.sellerUserName == self.data.sellers[i].sellerUserName) {
            self.setData({
              sellerObj_Index: i,
            });
            break;
          }
        }
      })
      var userInfoUrl = config.basePath + "api/userInfo/listAll" 
      utils.sendRequest(userInfoUrl, null, function (res) {
        wx.stopPullDownRefresh()
        self.setData({
          userInfos: res.data,
        })
        for (var i = 0; i < self.data.userInfos.length; i++) {
          if (evaluateRes.data.userObj.user_name == self.data.userInfos[i].user_name) {
            self.setData({
              userObj_Index: i,
            });
            break;
          }
        }
      })
    })
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
  },

})

