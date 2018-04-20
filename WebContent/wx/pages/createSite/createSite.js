// pages/createSite/createSite.js
import { provinces } from '../../utils/provinces';
const app = getApp();

Page({
  data: {
    provinces: provinces,
    provSelected: 1,
    siteType: ['育肥猪场', '二元猪场', '种猪场', '商品猪场'],
    siteTypeIndex: 0,
    inputData: {}
  },
  provSelectChange: function (e) {
    this.setData({
      provSelected: e.detail.value
    })
  },
  siteTypeChange(e) {
    this.setData({
      siteTypeIndex: e.detail.value
    })
  },
  inputHandle(event) {
    let id = event.currentTarget.id;
    let value = event.detail.value;
    let objectData = this.data.inputData;
    objectData[id] = value;
    this.setData({
      inputData: objectData
    });
  },
  newSite() {
    let inputData = this.data.inputData;
    let { provinces, siteType, provSelected, siteTypeIndex} = this.data;
    inputData = { 
      ...inputData,
      province: provinces[provSelected].name,
      farmTypeId: siteTypeIndex
      };
    //console.log('输入数据',inputData);
    if (app.globalData.editSite) {
      inputData = { ...inputData, farmId: app.globalData.defaultSite.farmId}
    }
    app.services({
      url: 'saveFarm',
      data: inputData,
      method: 'post',
      success(res) {
        let result = res.data;
        if (result.result == 'OK') {
          wx.showToast({
            title: result.msg,
            icon: 'success',
            duration: 800
          })
          //创建成功后跳转
          wx.navigateTo({
            url: '../siteManage/siteManage',
          })
        }
        else {
          wx.hideToast();
          wx.showModal({
            title: '',
            content: result.msg,
            success: res => {
              if (res.confirm) {

              }
            }
          })
        }
      },
      loading: true
    });
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
    if (app.globalData.editSite) {
      wx.setNavigationBarTitle({
        title: '编辑猪场'//页面标题为路由参数
      });

      let { companyId, farmId, farmTypeId, province, ...inputData } = app.globalData.defaultSite;
      let provSelected = 0;
      for (var i = 0; i < provinces.length; i++){
        if (provinces[i].name == province){
          provSelected = i;
          break; 
        }
      }

      this.setData({
        inputData,
        provSelected,
        siteTypeIndex: farmTypeId
      });
    }
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