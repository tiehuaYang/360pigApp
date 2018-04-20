//index.js
//获取应用实例
const app = getApp()

Page({
  data: {
    motto: '',
    userInfo: {},
    hasUserInfo: false,
    canIUse: false,

    username: wx.getStorageSync('username'),
    password: wx.getStorageSync('password'),
    remebePs: wx.getStorageSync('remebePsd') == "" ? false : wx.getStorageSync('remebePsd'),
    remebePsd: wx.getStorageSync('remebePsd') == "" ? false : wx.getStorageSync('remebePsd')
  },
  //事件处理函数
  bindViewTap: function () {
    wx.navigateTo({
      url: '../logs/logs'
    })
  },
  onLoad: function () {
    if(wx.canIUse){
      this.setData({
        canIUse: wx.canIUse('button.open-type.getUserInfo')
      })
    }
    if (app.globalData.userInfo) {
      this.setData({
        userInfo: app.globalData.userInfo,
        hasUserInfo: true,
      })
    } else if (this.data.canIUse) {
      // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
      // 所以此处加入 callback 以防止这种情况
      app.userInfoReadyCallback = res => {
        this.setData({
          userInfo: res.userInfo,
          hasUserInfo: true
        })
      }
    } else {
      // 在没有 open-type=getUserInfo 版本的兼容处理
      wx.getUserInfo({
        success: res => {
          app.globalData.userInfo = res.userInfo
          this.setData({
            userInfo: res.userInfo,
            hasUserInfo: true
          })
        }
      })
    }
  },
  getUserInfo: function (e) {
    console.log(e)
    app.globalData.userInfo = e.detail.userInfo
    this.setData({
      userInfo: e.detail.userInfo,
      hasUserInfo: true
    })
  },
  linksetting: function () {
    let { username, password, remebePsd } = this.data;
    let _this = this;
    let sendData = {
      userAccount: username,
      passwd: password
    }

    app.services({
      url: 'login',
      data: sendData,
      method: 'POST',
      success(res) {
        let result = res.data;
        if (result.result == 'OK') {
          wx.setStorageSync('userInfo', result);
          wx.showToast({
            title: '登录成功',
            icon: 'success',
            duration: 800
          })
          if (remebePsd == true) {
            wx.setStorageSync('username', username)
            wx.setStorageSync('password', password)
            wx.setStorageSync('remebePsd', remebePsd)
          } else {
            wx.setStorageSync('username', '')
            wx.setStorageSync('password', '')
            wx.setStorageSync('remebePsd', remebePsd)
          }
          wx.switchTab({
            url: '../entering/entering'
          })
        }
        else {
          wx.hideToast();
          wx.showModal({
            title: '',
            content: result.msg,
            success: res => {
              if (res.confirm) {
                _this.setData({
                  password: ''
                });
              } else if (res.cancel) {

              }
            }
          })
        }
      },
      loading: true,
      loadingTitle: '正在登陆'
    });
  },
  userNameInput(event) {
    this.setData({
      username: event.detail.value
    });
  },
  passWordeInput(event) {
    this.setData({
      password: event.detail.value
    });
  },
  remebePsd(event) {
    this.setData({
      remebePsd: !this.data.remebePsd
    });
  },
})
