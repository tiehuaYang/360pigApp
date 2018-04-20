// pages/breeding/breeding.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    dates: '年-月-日',
    dates2: '年-月-日',
    objectArray: ['一', '二'],
    boarArray: ['有', '无'],
    boar2Array: ['无', '有'],
    array: ['分娩舍', '备孕舍'],
    index: 0,
    location: 0,
    boar: 0,
    boar2: 0
  },
  listenerPickerChange: function (e) {
    this.setData({
      boar: e.detail.value
    });
  },
  listenerPickerChange2: function (e) {
    this.setData({
      boar2: e.detail.value
    });
  },
  listenerPickerSelected: function (e) {
    //改变index值，通过setData()方法重绘界面
    this.setData({
      location: e.detail.value
    });
  },
  bindPickerChange: function (e) {
    console.log(e.detail.value)
    this.setData({
      index: e.detail.value
    })
  },
  bindDateChange: function (e) {
    console.log(e.detail.value)
    this.setData({
      dates: e.detail.value
    })
  },
  bindDateChange2: function (e) {
    console.log(e.detail.value)
    this.setData({
      dates2: e.detail.value
    })
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    var date = new Date();
    var year = date.getFullYear(); //获取完整的年份(4位,1970-????)
    var month = date.getMonth() + 1; //获取当前月份(0-11,0代表1月)
    var date1 = date.getDate(); //获取当前日(1-31)
    if (month < 10) {
      month = "0" + month;
    }
    if (date1 < 10) {
      date1 = "0" + date1;
    }
    date = year + '-' + month + '-' + date1;
    this.setData({
      date: date,
      pigIndate: date,
      today: date
    });

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