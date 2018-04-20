// pages/breedingRecord/breedingRecord.js

var app = getApp();
Page({

  /**
   * 页面的初始数据
   * 
   */
  seclectComponnent() {},
  data: {
    items: [
      {
        
      }
    ]
  },
  breeding() {
    wx.navigateTo({
      url: '../breeding/breeding'
    })
  },
  pigScreen() {
    wx.navigateTo({
      url: '../pigScreening/pigScreening'
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
  
  },
  _searchPigs(e) {
    console.log(e.detail);
    let _this = this;
    app.services({
      url: 'queryMating',
      data: { femalePigsId: e.detail.value },
      complete: function (result) {
        let res = result.data;
        console.log(res);

        _this.setData({
          
        });
        wx.hideToast();//关闭loading提示
      },
      loading: true
    });
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {
    if (wx.canIUse){
      if (wx.canIUse("selectComponent")){
        this.searchpigs = this.selectComponent("#searchpigs");
        this.searchpigs.setData({
          inputShowed: true
        });
      }
    }

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