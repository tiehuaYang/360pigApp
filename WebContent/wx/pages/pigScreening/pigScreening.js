// pages/pigScreening/pigScreening.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    dates: '年-月-日',
    dates2: '年-月-日',
    array: ['分娩舍','备孕舍'],
    index: 0,
    genter: 0, //猪只类别 0-母猪 1-公猪 2-仔猪
    isin: 1, //是否在场 1-在场 0-不在场
    pigState: { //猪只状态
      hasChild: true,
      breastfeeding: true,
      breakChild: true,
      backup: true
    },
    varieties: { //品种
      changbai: true,
      dabai: true,
      eryuan: true,
      dulk: true
    },
    parityMin: 0, //最小胎次
    parityMax: 15 //最大胎次
  },
  bindDateChange: function (e) {
    this.setData({
      dates: e.detail.value
    })
  },
  bindDateChange2: function (e) {
    this.setData({
      dates2: e.detail.value
    })
  },
  bindPickerChange(e) {
    this.setData({
      index: e.detail.value
    });
  },
  genderTap(e) {
    let genter = e.target.dataset.gender;
    let isin = e.target.dataset.isin;
    let state = e.target.dataset.state;
    let variet = e.target.dataset.variet;
    if (genter !== undefined) {
      //猪只类别
      this.setData({
        genter: genter
      });
    }
    if (isin !== undefined) {
      //猪只是否在场
      this.setData({
        isin: isin
      });
    }
    if (state !== undefined) {
      //猪只状态
      let pigState = this.data.pigState;
      pigState[state] = !this.data.pigState[state];
      this.setData({
        pigState: pigState
      });
    }
    if (variet !== undefined) {
      //猪只品种
      let varieties = this.data.varieties;
      varieties[variet] = !this.data.varieties[variet];
      this.setData({
        varieties: varieties
      });
    }
  },
  parityMinInput(e) {
    this.setData({
      parityMin: e.detail.value
    })
  },
  parityMaxInput(e) {
    this.setData({
      parityMax: e.detail.value
    })
  },
  comfirm() {
    let { genter, isin, pigState, varieties} = this.data;
    console.log(genter, isin, pigState, varieties);
    wx.navigateBack({
      url: '../pigs/pigs'
    })
  },
  cancel() {
    wx.navigateBack({
      url: '../pigs/pigs'
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