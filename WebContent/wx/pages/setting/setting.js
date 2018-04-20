const app = getApp();

Page({
  data: {
    actionSheetHidden: true,
    actionSheetItems: [
      { bindtap: 'Menu1', txt: '退出登录' }
    ],
    menu: '',
  },
  actionSheetTap: function () {
    this.setData({
      actionSheetHidden: !this.data.actionSheetHidden
    })
  },
  actionSheetbindchange: function () {
    this.setData({
      actionSheetHidden: !this.data.actionSheetHidden
    });
  },
  siteActionSheetTap() {
    wx.navigateTo({
      url: '../siteManage/siteManage',
    })
  },

  bindMenu1: function () {
    this.setData({
      menu: 1,
      actionSheetHidden: !this.data.actionSheetHidden
    });
    wx.redirectTo({
      url: '../index/index',
    })
  },
  bindOperat1: function () {
    
  },
  bindOperat2: function () {
    
  },
  siteManage() {
    wx.navigateTo({
      url: '../siteManage/siteManage',
    })
    this.setData({
      notDefaultSite: 0
    });
  },
  onLoad(option) {
    var value = wx.getStorageSync('userInfo');
    this.setData({
      userInfo: value,
      notDefaultSite: app.globalData.notDefaultSite
    });
  },
  getSupplier() {
    wx.navigateTo({
      url: '../supplierManage/supplierManage',
    })
  },
  materialManage() {
    wx.navigateTo({
      url: '../materialManage/materialManage',
    })
  },
})