// pages/addMaterial/addMaterial.js
const app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
    inputData: {},
    editmaterialId: '',//物料ID（编辑时有值）

    name: '',
    feedPhaseORfeedType: '',
    itemView: true,

    pigType: ['全部', '种猪','肉猪'],
    pigTypeIndex: '0',
    stageORType: [],
    stageORTypeIndex: '0',
    supplier: [],
    supplierIndex: '0'

    
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
  newSupplier() {
    let { materialTab, inputData, editmaterialId, pigTypeIndex, stageORTypeIndex, supplier, supplierIndex} = this.data;
    inputData = { 
      ...inputData,
      supplierId: supplier[supplierIndex].supplierId,
      pigType: pigTypeIndex
    }
    if (materialTab == '0'){
      inputData.stage = stageORTypeIndex;
      inputData.type = materialTab;
    }
    else if (materialTab == '1') {
      inputData.type = parseInt(stageORTypeIndex) + 1;
    }
    else if (materialTab == '2') {
      inputData.type = parseInt(materialTab) + 1;
    }
    
    //console.log('输入数据',inputData);
    if (editmaterialId != '') {
      //编辑供应商时需要的supplierId加入到参数中
      inputData = { ...inputData, goodId: editmaterialId }
    }
    if (inputData.goodName == undefined || inputData.goodName == "") {
      wx.showToast({
        title: "名称不能为空",
        icon: 'none',
        duration: 2000
      })
      return;
    }
    app.services({
      url: 'saveGoods',
      method: 'post',
      data: inputData,
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          });
          wx.redirectTo({
            url: '../materialManage/materialManage',
          })
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
      loading: true,
      loadingTitle: '保存中...'
    });
  },
  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let _this = this;

    if (options && options.id) {
      wx.setNavigationBarTitle({
        title: '编辑物料'//页面标题为路由参数
      });
      this.setData({
        editmaterialId: options.id
      });
      app.services({
        url: 'fetchGoods',
        data: { goodId: options.id },
        success(result) {
          let res = result.data;
          if (res.result == 'OK') {
            let { goodName, type, pigType, supplierId} = res.goodsVO;
            _this.setData({
              inputData: { goodName: goodName},
              pigTypeIndex: pigType,
              stageORTypeIndex: options.type == '1' ? (type-1):type,
              supplierId: supplierId
            });
          }
        }
      });
    }
    if (options.type == 2){
      app.services({
        url: 'querySupplier',
        data: { type: parseInt(options.type) + 1 },
        success(result) {
          let res = result.data;
          if (res.result == 'OK') {
            for (var i = 0; i < res.supplierVOs.length; i++) {
              if (res.supplierVOs[i].supplierId == _this.data.supplierId) {
                _this.setData({
                  supplierIndex: i,
                });
                break;
              }
            }
            _this.setData({
              supplier: res.supplierVOs,
            });
          }
        }
      });
    }else{
      app.services({
        url: 'querySupplier',
        data: { type: options.type },
        success(result) {
          let res = result.data;
          if (res.result == 'OK') {
            for (var i = 0; i < res.supplierVOs.length; i++) {
              if (res.supplierVOs[i].supplierId == _this.data.supplierId) {
                _this.setData({
                  supplierIndex: i,
                });
                break;
              }
            }
            _this.setData({
              supplier: res.supplierVOs,
            });
          }
        }
      });
    }
    switch (options.type) {
      case '0':
        this.setData({
          name: '饲料名称',
          feedPhaseORfeedType: '饲料阶段',
          stageORType: ['怀孕料', '哺乳料', '后备料', '空怀料','公猪料'],
          materialTab: options.type
        });
        this.querySupplier(options.type);
        break;
      case '1':
        this.setData({
          name: '兽药名称',
          feedPhaseORfeedType: '物料类型',
          stageORType: ['兽药', '疫苗'],
          materialTab: options.type
        });
        this.querySupplier(options.type);
        break;
      case '2':
        this.setData({
          name: '精液名称',
          feedPhaseORfeedType: '',
          itemView: false,
          materialTab: options.type
        });
        break;
        this.querySupplier(parseInt(options.type) +1);
      default: ''
    }
  },
  querySupplier(type){
    var _this = this;
    app.services({
      url: 'querySupplier',
      data: { type: type },
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          for (var i = 0; i < res.supplierVOs.length; i++) {
            if (res.supplierVOs[i].supplierId == _this.data.supplierId) {
              _this.setData({
                supplierIndex: i,
              });
              break;
            }
          }
          _this.setData({
            supplier: res.supplierVOs,
          });
        }
      }
    });
  },
  delMaterial() {
    let { editmaterialId } = this.data
    app.services({
      url: 'deleteGoods',
      data: { goodId: editmaterialId },
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          });
          wx.redirectTo({
            url: '../materialManage/materialManage',
          })
        }
      },
      loading: true,
      loadingTitle: '正在删除中'
    });
  },
  stageORTypeChange(e) {
    this.setData({
      stageORTypeIndex: e.detail.value
    })
    this.querySupplier(parseInt(stageORTypeIndex) + 1);
  },
  pigTypeChange(e) {
    this.setData({
      pigTypeIndex: e.detail.value
    })
  },
  supplierChange(e) {
    this.setData({
      supplierIndex: e.detail.value
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