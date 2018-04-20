// pages/siteManage/siteManage.js
var app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
    hasDefault: false
  },
  createSite() {
    //新建猪场
    app.globalData.editSite = false;
    app.globalData.defaultSite = {};
    wx.navigateTo({
      url: '../createSite/createSite',
    })
  },
  delSite() {
    const { farmId } = this.data.defaultSite;
    wx.showModal({
      title: '',
      content: '请确定删除猪场，如果猪场存在数据可能删除失败',
      showCancel: false,
      success: function (res) {
        if (res.confirm) {
          app.services({
            url: 'deleteFarm',
            data: { farmId: farmId },
            success: function (result) {
              let res = result.data;
              if(res.result == 'OK') {
                wx.showModal({
                  title: '',
                  content: '猪场删除成功，请重新选择默认猪场',
                  showCancel: false,
                  success: function (res) {
                    if (res.confirm) {
                      wx.navigateTo({
                        url: '../chooseSite/chooseSite',
                      })
                    }
                  }
                });
              }
              else if (res.result == 'FAIL') {
                wx.showModal({
                  title: '',
                  content: res.msg,
                  showCancel: false
                });
              }
              
            }
          });
        }
      }
    });
  },
  switchSite() {
    wx.navigateTo({
      url: '../chooseSite/chooseSite',
    })
  },
  managePage() {
    wx.navigateTo({
      url: '../piggeryManage/piggeryManage',
    })
  },
  editSite() {
    app.globalData.editSite = true;
    app.globalData.defaultSite = this.data.defaultSite;
    wx.navigateTo({
      url: '../createSite/createSite',
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
      url: 'queryDefaultFarm',
      data: {},
      success: function (result) {
        let res = result.data;
        if(!res.farmVO) {
          //没有默认猪场
          app.services({
            url: 'queryFarm',
            data: {},
            success: function (result1) {
              let res1 = result1.data;
              if (res1.farmVO.length>0) {
                //提示
                wx.showModal({
                  title: '',
                  content: '还没有默认猪场，去选择默认猪场',
                  showCancel: false,
                  success: function (res) {
                    if (res.confirm) {
                      wx.navigateTo({
                        url: '../chooseSite/chooseSite', 
                      })
                    }
                  }
                });
              }
              else{
                //提示
                wx.showModal({
                  title: '',
                  content: '还没有猪场，去新建猪场',
                  showCancel: false,
                  success: function (res) {
                    if (res.confirm) {
                      wx.navigateTo({
                        url: '../createSite/createSite',
                      })
                    }
                  }
                });
              }
            },
            loading: false
          });

        }
        else {
          _this.setData({
            defaultSite: res.farmVO,
            hasDefault: true
          });
        }
      },
      loading: false
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