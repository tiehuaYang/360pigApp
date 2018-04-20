// pages/deathRecord/deathRecord.js
Page({

  /**
   * 页面的初始数据
   */
  seclectComponnent() { },
  data: {
  
  },
  pigScreen() {
    wx.navigateTo({
      url: '../pigScreening/pigScreening'
    })
  },
  deathAdd() {
    wx.navigateTo({
      url: '../deathAdd/deathAdd'
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
      url: 'queryPig',
      data: { earTag: e.detail.value },
      complete: function (result) {
        let res = result.data;
        console.log(res);
        //处理数据
        for (var i in res.pigsList) {
          res.pigsList[i].admissionDate = res.pigsList[i].admissionDate.substring(0, 10);
        }
        _this.setData({
          pigsList: res.pigsList,
          countPig: res.countPig,
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
    this.searchbar = this.selectComponent("#searchbar");
    this.searchbar.setData({
      inputShowed: true
    });
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