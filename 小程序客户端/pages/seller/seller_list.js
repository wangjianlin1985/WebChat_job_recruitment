var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    queryViewHidden: true, //是否隐藏查询条件界面
    sellerUserName: "", //商家账号查询关键字
    sellerName: "", //商户名称查询关键字
    telephone: "", //联系电话查询关键字
    shenHeState: "", //审核状态查询关键字
    addTime: "", //注册时间查询关键字
    sellers: [], //界面显示的商家列表数据
    page_size: 8, //每页显示几条数据
    page: 1,  //当前要显示第几页
    totalPage: null, //总的页码数
    loading_hide: true, //是否隐藏加载动画
    nodata_hide: true, //是否隐藏没有数据记录提示
  },

  // 加载商家列表
  listSeller: function () {
    var self = this
    var url = config.basePath + "api/seller/list"
    //如果要显示的页码超过总页码不操作
    if(self.data.totalPage != null && self.data.page > self.data.totalPage) return
    self.setData({
      loading_hide: false,  //显示加载动画
    })
    //提交查询参数到服务器查询数据列表
    utils.sendRequest(url, {
      "sellerUserName": self.data.sellerUserName,
      "sellerName": self.data.sellerName,
      "telephone": self.data.telephone,
      "shenHeState": self.data.shenHeState,
      "addTime": self.data.addTime,
      "page": self.data.page,
      "rows": self.data.page_size,
    }, function (res) { 
      wx.stopPullDownRefresh()
      setTimeout(function () {  
        self.setData({
          sellers: self.data.sellers.concat(res.data.list),
          totalPage: res.data.totalPage,
          loading_hide: true
        })
      }, 500)
      //如果当前显示的是最后一页，则显示没数据提示
      if(self.data.page == self.data.totalPage) {
        self.setData({
          nodata_hide: false,
        })
      }
    })
  },

  //显示或隐藏查询视图切换
  toggleQueryViewHide: function () {
    this.setData({
      queryViewHidden: !this.data.queryViewHidden,
    })
  },

  //点击查询按钮的事件
  querySeller: function(e) {
    var self = this
    self.setData({
      page: 1,
      totalPage: null,
      sellers: [],
      loading_hide: true, //隐藏加载动画
      nodata_hide: true, //隐藏没有数据记录提示 
      queryViewHidden: true, //隐藏查询视图
    })
    self.listSeller()
  },

  //绑定查询参数输入事件
  searchValueInput: function (e) {
    var id = e.target.dataset.id
    if (id == "sellerUserName") {
      this.setData({
        "sellerUserName": e.detail.value,
      })
    }

    if (id == "sellerName") {
      this.setData({
        "sellerName": e.detail.value,
      })
    }

    if (id == "telephone") {
      this.setData({
        "telephone": e.detail.value,
      })
    }

    if (id == "shenHeState") {
      this.setData({
        "shenHeState": e.detail.value,
      })
    }

    if (id == "addTime") {
      this.setData({
        "addTime": e.detail.value,
      })
    }

  },

  init_query_params: function() { 
    var self = this
    var url = null
  },

  //删除商家记录
  removeSeller: function (e) {
    var self = this
    var sellerUserName = e.currentTarget.dataset.sellerusername
    wx.showModal({
      title: '提示',
      content: '确定要删除sellerUserName=' + sellerUserName + '的记录吗？',
      success: function (sm) {
        if (sm.confirm) {
          // 用户点击了确定 可以调用删除方法了
          var url = config.basePath + "api/seller/delete/" + sellerUserName
          utils.sendRequest(url, null, function (res) {
            wx.stopPullDownRefresh();
            wx.showToast({
              title: '删除成功',
              icon: 'success',
              duration: 500
            })
            //删除商家后客户端同步删除数据
            var sellers = self.data.sellers;
            for (var i = 0; i < sellers.length; i++) {
              if (sellers[i].sellerUserName == sellerUserName) {
                sellers.splice(i, 1)
                break
              }
            }
            self.setData({ sellers: sellers })
          })
        } else if (sm.cancel) {
          console.log('用户点击取消')
        }
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.listSeller()
    this.init_query_params()
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    var self = this
    self.setData({
      page: 1,  //显示最新的第1页结果
      sellers: [], //清空商家数据
      nodata_hide: true, //隐藏没数据提示
    })
    self.listSeller()
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    var self = this
    if (self.data.page < self.data.totalPage) {
      self.setData({
        page: self.data.page + 1, 
      })
      self.listSeller()
    }
  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }

})

