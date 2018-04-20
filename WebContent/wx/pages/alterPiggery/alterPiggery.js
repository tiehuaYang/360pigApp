// pages/alterPiggery/alterPiggery.js
var app = getApp();
var piggerys = ['分娩舍', '备孕舍', '育肥舍','公猪舍' ]
Page({

  /**
   * 页面的初始数据
   */
  data: {
    selectPiggery: true,
    firstPiggery: '选择猪舍类型',
    selectArea: false,
    piggeryName: '',
    piggerys,
    piggeryId: '',
  },
  clickPiggery: function () {
    var selectPiggery = this.data.selectPiggery;
    if (selectPiggery == true) {
      this.setData({
        selectArea: true,
        selectPiggery: false,
      })
    } else {
      this.setData({
        selectArea: false,
        selectPiggery: true,
      })
    }
  },
  //点击切换
  mySelect: function (e) {
    console.log(e);
    this.setData({
      firstPiggery: e.target.dataset.me,
      selectPiggery: true,
      selectArea: false,
    })
  },
  saveAlter() {
    let { piggeryName, firstPiggery, piggeryId } = this.data;
    let _data = { penName: piggeryName, penTypeId: firstPiggery, penId: piggeryId};
    app.services({
      url: 'savePen',
      data: _data,
      method: 'post',
      success: function (result) {
        var e = result.data;
        if (e.result == 'FAIL') {
          wx.showToast({
            title: e.msg,
            icon: 'cancel',
            duration: 800
          })
        }
        else if (e.result == 'OK') {
          wx.showToast({
            title: e.msg,
            icon: 'success',
            duration: 800
          })
          wx.redirectTo({
            url: '../piggeryManage/piggeryManage',
          })
        }
      },
      loading: true
    })
  },
  typeName(e) {
    var value = e.detail.value;
    this.setData({
      piggeryName: value
    });
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(options);
    this.setData({
      piggeryId: options.id,
      piggeryName: options.name,
      firstPiggery: options.type
    })

  },
  deletePiggery() {
    app.services({
      url:'deletePen',
      data: { penId: this.data.piggeryId},
      success: function(res) {
        var e = res.data;
        if(e.result == 'FAIL') {
          wx.showToast({
            title: e.msg,
            icon: 'none',
            duration: 800
          })
        }
        else if (e.result == 'OK') {
          wx.showToast({
            title: e.msg,
            icon: 'success',
            duration: 800
          })
          wx.redirectTo({
            url: '../piggeryManage/piggeryManage',
          })
        }
      },
      loading: true,
      loadingTitle: '正在删除'
    })
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