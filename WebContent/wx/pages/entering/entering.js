// pages/entering/entering.js
var app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
  },
  

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    //showView: (options.showView == "true" ? true : false)
    app.services({
      url: 'queryDefaultFarm',
      data: {},
      success: function (result) {
        let res = result.data;
        if (!res.farmVO) {
          //没有默认猪场
          wx.showModal({
            title: '',
            content: '还没有设置默认猪场，去设置猪场管理',
            showCancel: false,
            success: function (res) {
              if (res.confirm) {
                wx.switchTab({
                  url: '../setting/setting',
                });
                app.globalData.notDefaultSite = 1;
              }
            }
          });
        }
      }
    })
  },
  breedingRecord() {
    wx.navigateTo({
      url: '../breedingRecord/breedingRecord'
    })
  },
  childbirthRecord() {
    wx.navigateTo({
      url: '../childbirthRecord/childbirthRecord'
    })
  },
  deathRecord() {
    wx.navigateTo({
      url: '../deathRecord/deathRecord'
    })
  },
  gestation() {
    wx.navigateTo({
      url: '../gestation/gestation'
    })
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