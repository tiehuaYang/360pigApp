//app.js
App({
  //设置域名baseUrl & 接口api & 请求services
  baseUrl: 'https://360pig.mtoon.com.cn',
  //baseUrl: 'http://192.168.0.200:8080/360pig',
  api: {
    login: '/appLogin',
    saveFarm: '/app/saveFarm',
    queryFarm: '/app/queryFarm',
    queryDefaultFarm: '/app/queryDefaultFarm',
    usingFarm: '/app/usingFarm',
    deleteFarm: '/app/deleteFarm',
    savePen: '/app/savePen',
    queryPen: '/app/queryPen',
    savePig: '/app/savePig',
    deletePen: '/app/deletePen',
    saveSupplier: '/app/saveSupplier',
    querySupplier: '/app/querySupplier',
    fetchSupplier: '/app/fetchSupplier',
    deleteSupplier: '/app/deleteSupplier',
    saveGoods: '/app/saveGoods',
    queryGoods: '/app/queryGoods',
    queryPigCategory: '/app/queryPigCategory',
    queryPigStrain: '/app/queryPigStrain',
    fetchGoods: '/app/fetchGoods',
    deleteGoods: '/app/deleteGoods',
    queryPig: '/app/queryPig',
    fetchPig: '/app/fetchPig',
    deletePig: '/app/deletePig',
    summaryFemale: "/app/summaryFemale",
    summaryMale: "/app/summaryMale",
    summaryPorker: "/app/summaryPorker",
    summaryFemalePregnant: "/app/summaryFemalePregnant",
    summaryFemaleNonpregnancy: "/app/summaryFemaleNonpregnancy",
    summaryWait: "/app/summaryWait",
    summaryWaitMatingReturn: "/app/summaryWaitMatingReturn",
    summaryWaitMatingEmpty: "/app/summaryWaitMatingEmpty",
    summaryWaitMatingAbortion: "/app/summaryWaitMatingAbortion",
    summaryWaitExpectant: "/app/summaryWaitExpectant",
    summaryPigIn: "/app/summaryPigIn",
    summaryPigMating: "/app/summaryPigMating",
    summaryPigPregnancy: "/app/summaryPigPregnancy",
    summaryBreedingTrackByMonth: "/app/summaryBreedingTrackByMonth",
    summaryBreedingTrackByWeek: "/app/summaryBreedingTrackByWeek",

    getPigByEarTag: "/app/getPigByEarTag",
    queryMating: "/app/queryMating"
  },
  /* options = {}
  url: '接口api'

   */
  services: function (options) {
    var url = this.baseUrl + this.api[options.url];
    if (options.method) {
      var method = options.method.toUpperCase();
    }
    else {
      var method = false;
    }
    if (!options.header) {
      const { sessionId } = wx.getStorageSync('userInfo');
      if (sessionId) {
        options.header = { 'Cookie': 'JSESSIONID=' + sessionId };
      }
    }
    if (options.loading)
      wx.showToast({
        title: options.loadingTitle || '正在加载中',
        icon: 'loading',
        duration: 30000
      });
    wx.request({
      url: url,
      data: options.data || {},
      header: options.header,
      method: method || 'GET',
      dataType: options.dataType || 'json',
      success: options.success,
      fail: res => {
        /*wx.showModal({
          title: '',
          content: '请求错误，请重试',
          showCancel: false
        })*/
        if (options.fail) ooptions.fail(res)
      },
      complete: res => {
        if (res.data) {
          let msg = res.data.msg;
          if (msg && msg.includes('登录超时')) {
            wx.showModal({
              title: '',
              content: msg,
              success: res => {
                if (res.confirm) {
                  wx.reLaunch({
                    url: '../index/index'
                  })
                }
              }
            })
          }
        }
        if (options.complete) options.complete(res)
      }
    })
  },
  onLaunch: function () {

    // 登录
    wx.login({
      success: res => {
        // 发送 res.code 到后台换取 openId, sessionKey, unionId
      }
    })
    // 获取用户信息
    if (wx.canIUse) {
      if (wx.canIUse("wx.getSetting")) {
        wx.getSetting({
          success: res => {
            if (res.authSetting['scope.userInfo']) {
              // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
              wx.getUserInfo({
                success: res => {
                  // 可以将 res 发送给后台解码出 unionId
                  this.globalData.userInfo = res.userInfo

                  // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
                  // 所以此处加入 callback 以防止这种情况
                  if (this.userInfoReadyCallback) {
                    this.userInfoReadyCallback(res)
                  }
                }
              })
            }
          }
        })
      }
    }
  },
  globalData: {
    userInfo: null,
    notDefaultSite: 0,
    editSite: false,
    defaultSite: {}
  }
})