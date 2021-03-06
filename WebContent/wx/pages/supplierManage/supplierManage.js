// pages/supplierManage/supplierManage.js
const app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
    supplierList: []
  },
  _searchSupplier(e) {
    console.log(e.detail);
    let _this = this;
    let supplierName = e.detail.value;
    app.services({
      url: 'querySupplier',
      data: { supplierName: supplierName},
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          wx.hideToast();
          let supplierList = res.supplierVOs;
          _this.setData({
            supplierList: supplierList
          });
        }
        if (res.result == 'FAIL') {
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 1000
          });
        }
      },
      loading: true,
      loadingTitle: '正在搜索'
    });
  },
  addSupplier() {
    wx.navigateTo({
      url: '../addSupplier/addSupplier',
    })
  },
  editSupplier(e) {
    let id = e.target.dataset.id;
    wx.navigateTo({
      url: '../addSupplier/addSupplier?id='+id,
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
    let _this = this;
    app.services({
      url: 'querySupplier',
      success(result) {
        let res = result.data;
        if(res.result == 'OK') {
          wx.hideToast();
          let supplierList = res.supplierVOs;
          _this.setData({
            supplierList: supplierList
          });
        }
        if (res.result == 'FAIL') {
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 1000
          });
        }
      },
      loading: true
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