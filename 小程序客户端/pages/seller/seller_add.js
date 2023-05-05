var utils = require("../../utils/common.js");
var config = require("../../utils/config.js");

Page({
  /**
   * 页面的初始数据
   */
  data: {
    sellerUserName: "", //商家账号
    password: "", //预留密码段
    sellerName: "", //商户名称
    sellerPhoto: "upload/NoImage.jpg", //商户照片
    sellerPhotoList: [],
    workContent: "", //经营内容
    workTime: "", //经营时间
    telephone: "", //联系电话
    workAddress: "", //工作地址
    workLicense: "upload/NoImage.jpg", //营业许可证
    workLicenseList: [],
    scoreValue: "", //评价分数
    shenHeState: "", //审核状态
    addTime: "", //注册时间
    loadingHide: true,
    loadingText: "网络操作中。。",
  },

  /*提交添加商家到服务器 */
  formSubmit: function (e) {
    var self = this;
    var formData = e.detail.value;
    var url = config.basePath + "api/seller/add";
    utils.sendRequest(url, formData, function (res) {
      wx.stopPullDownRefresh();
      wx.showToast({
        title: '发布成功',
        icon: 'success',
        duration: 500
      })

      //提交成功后重置表单数据
      self.setData({
        sellerUserName: "",
    password: "",
    sellerName: "",
        sellerPhoto: "upload/NoImage.jpg",
        sellerPhotoList: [],
    workContent: "",
    workTime: "",
    telephone: "",
    workAddress: "",
        workLicense: "upload/NoImage.jpg",
        workLicenseList: [],
    scoreValue: "",
    shenHeState: "",
    addTime: "",
        loadingHide: true,
        loadingText: "网络操作中。。",
      })
    });
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
          loadingHide: false
        });
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              sellerPhoto: res.data,
              loadingHide: true
            });
          }, 200);
        });
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
          loadingHide: false
        });
        utils.sendUploadImage(config.basePath + "upload/image", tempFilePaths[0], function (res) {
          wx.stopPullDownRefresh()
          setTimeout(function () {
            self.setData({
              workLicense: res.data,
              loadingHide: true
            });
          }, 200);
        });
      }
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
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

