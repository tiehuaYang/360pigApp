// pages/piggeryManage/piggeryManage.js
var app = getApp();
Page({

  /**
   * 页面的初始数据
   */
  data: {
    piggeryList: []
  },
  createPiggery() {
    wx.navigateTo({
      url: '../clickCreate/clickCreate',
    })
  },
  alterPage(e) {
    var id = e.target.dataset.id;
    var index = e.target.dataset.index;
    var name = this.data.piggeryList[index].penName;
    var type = this.data.piggeryList[index].penTypeId;
    wx.navigateTo({
      url: '../alterPiggery/alterPiggery?id=' + id + '&' + 'name=' + name + '&' + 'type=' + type,
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
    var _this = this;
    app.services ({
      url: 'queryPen',
      data: {},
      success(e){
        wx.hideToast();
        var farmVO = e.data.farmVO;
        _this.setData({
          piggeryList: farmVO,
        })
      },
      loading: true
    })
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