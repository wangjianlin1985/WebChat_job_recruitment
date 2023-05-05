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
    sellerPhoto: "upload/NoImage.jpg", //商户照片
    sellerPhotoUrl: "",
    sellerPhotoList: [],
    workContent: "", //经营内容
    workTime: "", //经营时间
    telephone: "", //联系电话
    workAddress: "", //工作地址
    workLicense: "upload/NoImage.jpg", //营业许可证
    workLicenseUrl: "",
    workLicenseList: [],
    scoreValue: "", //评价分数
    shenHeState: "", //审核状态
    addTime: "", //注册时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  //选择商户照片上传
  select_sellerPhoto: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          sellerPhotoList: tempFilePaths,
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              sellerPhoto: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //选择营业许可证上传
  select_workLicense: function (e) {
    var self = this
    wx.chooseImage({
      count: 1,   //可以上传一张图片
      sizeType: ['original', 'compressed'],
      sourceType: ['album', 'camera'],
      success: function (res) {
        var tempFilePaths = res.tempFilePaths
        self.setData({
          workLicenseList: tempFilePaths,
          loadingHide: false, 
        });

        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              workLicense: res.data,
              loadingHide: true
            })
          }, 200)
        })
      }
    })
  },

  //提交服务器修改商家信息
  formSubmit: function (e) {
    var self = this
    var formData = e.detail.value
    var url = config.basePath + "api/seller/update"
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '修改成功',
        icon: 'success',
        duration: 500
      })

      //服务器修改成功返回列表页更新显示为最新的数据
      var pages = getCurrentPages()
      var sellerlist_page = pages[pages.length - 2];
      var sellers = sellerlist_page.data.sellers
      for(var i=0;i<sellers.length;i++) {
        if(sellers[i].sellerUserName == res.data.sellerUserName) {
          sellers[i] = res.data
          break
        }
      }
      sellerlist_page.setData({sellers:sellers})
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

