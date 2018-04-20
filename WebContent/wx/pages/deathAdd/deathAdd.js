// pages/deathAdd/deathAdd.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    dates: '年-月-日',
    array: ['分娩舍', '备孕舍'],
    typeArray: ['淘汰','死亡'],
    reasonArray: ['长期不发情','死亡'],
    location: 0,
    deathType: 0,
    deathReason: 0
  
  },
  bindDateChange: function (e) {
    this.setData({
      dates: e.detail.value
    })
  },
  listenerPickerSelected: function (e) {
    //改变index值，通过setData()方法重绘界面
    this.setData({
      location: e.detail.value
    });
  }, 
  deathTypeSelected: function(e) {
    this.setData({
      deathType: e.detail.value
    });
  },
  deathReasonSelected: function(e) {
    this.setData({
      deathReason: e.detail.value
    });
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