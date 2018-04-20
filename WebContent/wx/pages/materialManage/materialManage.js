var sliderWidth = 84; // 需要设置slider的宽度，用于计算中间位置
const app = getApp();

Page({
  data: {
    tabs: ["饲料", "兽药疫苗", "猪只精液"],
    materType: 1,
    sliderOffset: 0,
    sliderLeft: 0,

    stageORType: ['怀孕料', '哺乳料', '后备料', '空怀料', '公猪料'],
    pigType: ['全部', '种猪', '肉猪'],
  },
  onLoad: function () {
    var that = this;
    wx.getSystemInfo({
      success: function (res) {
        that.setData({
          sliderLeft: (res.windowWidth / that.data.tabs.length - sliderWidth) / 2,
          sliderOffset: res.windowWidth / that.data.tabs.length * that.data.materType
        });
      }
    });
    this.getMaterial('1');
  },
  tabClick: function (e) {
    this.setData({
      sliderOffset: e.currentTarget.offsetLeft,
      materType: e.currentTarget.id
    });
    var type = e.currentTarget.id;
    if(type == '2') type = '3';
    this.getMaterial(type);
  },
  _searchMaterial(e) {
    this.getMaterial(this.data.materType, e.detail.value)
  },
  addMaterial() {
    wx.navigateTo({
      url: '../addMaterial/addMaterial?type=' + this.data.materType,
    })
  },
  getMaterial(tabType,keyword) {
    let _this = this;
    if (tabType == '1') tabType = "1;2";
    let _data = { type: tabType }
    if (keyword) {
      _data.goodName = keyword;
    }
    app.services({
      url: 'queryGoods',
      method: 'post',
      data: _data,
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          wx.hideToast();
          /*wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          });*/
          _this.setData({
            materialList: res.goodsVOs
          });
        }
        if (res.result == 'FAIL') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 800
          });
        }
      },
      //loading: true
    });
  },
  editMaterial(e) {
    var id = e.target.dataset.materid;
    wx.navigateTo({
      url: '../addMaterial/addMaterial?type=' + this.data.materType + '&id=' + id,
    })
  },
});