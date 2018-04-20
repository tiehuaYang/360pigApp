// pages/staging/staging.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    waitMating:0,
    waitExpectant:0,
    femaleNum:0,
    maleNum:0,
    porkerNum:0,
    pregnantNum:0,
    nonpregnancyNum:0,
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
    let _this = this;
    app.services({
      url: 'summaryWait',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          waitMating: res.matingNum,
          waitExpectant: res.expectantNum,
        });
      },
      loading: true
    });
    app.services({
      url: 'summaryFemale',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          femaleNum: res.femaleNum,
        });
      },
    });
    app.services({
      url: 'summaryMale',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          maleNum: res.maleNum,
        });
      },
    });
    app.services({
      url: 'summaryPorker',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          porkerNum: res.porkerNum,
        });
      },
    });
    app.services({
      url: 'summaryFemalePregnant',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          pregnantNum: res.femaleNum,
        });
      },
    });
    app.services({
      url: 'summaryFemaleNonpregnancy',
      data: {},
      complete: function (result) {
        let res = result.data;
        _this.setData({
          nonpregnancyNum: res.femaleNum,
        });
        wx.hideToast();//关闭loading提示
      },
    });
  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

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

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})