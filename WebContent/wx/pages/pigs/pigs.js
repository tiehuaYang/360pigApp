// pages/pigs/pigs.js

var app = getApp();
Page({
  /**
   * 页面的初始数据
   */
  data: {
    loadMoreing: false,
    loadOver: false,
    states: ['后备','怀孕','分娩','返情','流产','空胎','公猪'],
    pigsEvent: ['入场', '配种', '分娩', '孕检','采精'],
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
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    
  },

  _searchPigs(e) {
    console.log(e.detail);
    let _this = this;
    app.services({
      url: 'queryPig',
      data: { earTag: e.detail.value},
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
  showMore(event) {
    let index = event.target.dataset.index;

    let pigsList = this.data.pigsList;
    pigsList[index].showMore = !this.data.pigsList[index].showMore;
    this.setData({
      pigsList: pigsList
    });
  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {
    let _this = this;
    app.services({
      url: 'apiKey',
      data: {},
      complete: function () {
        var res = pigsList;
        //处理数据
        _this.setData({
          pigsList: pigsList,
        });
        wx.hideToast();//关闭loading提示
      },
      loading: false
    });
  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {
    let _this = this;
    let isLoading = this.data.loadMoreing;
    if (!isLoading) {
      this.setData({
        loadMoreing: true
      });
      app.services({
        url: 'apiKey',
        data: {},
        complete: function () {
          var res = pigsList;
          //处理数据
          let newList = [..._this.data.pigsList, ...res];
          _this.setData({
            pigsList: newList,
            loadMoreing: false
          });
          wx.hideToast();//关闭loading提示
        },
        loading: true
      });
    }
  },
  screen() {
    wx.navigateTo({
      url: '../pigScreening/pigScreening'
    })
  },
  addPig() {
    wx.navigateTo({
      url: '../addPig/addPig'
    })
  },
  getPig(e) {
    var pigId = e.target.dataset.pigid;
    console.log(pigId);
    wx.navigateTo({
      url: '../addPig/addPig?pigid=' + pigId
    })
  },
  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {
    let _this = this;
    app.services({
      url: 'queryPig',
      data: {},
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
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  },
})