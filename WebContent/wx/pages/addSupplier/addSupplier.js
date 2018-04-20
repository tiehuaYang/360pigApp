// pages/addSupplier/addSupplier.js
const app = getApp();

Page({

  /**
   * 页面的初始数据
   */
  data: {
    supplierClass: { //供应商类别
      option0: true,
      option1: true,
      option2: true,
      option3: true,
      option4: true
    },
    inputData: {},
    editSupplierId: '',//供应商ID（编辑供应商时有值）
  },
  categoryTap(e) {
    let category = e.target.dataset.state;
    if (category !== undefined) {
      //猪只状态
      let supplierClass = this.data.supplierClass;
      supplierClass[category] = !this.data.supplierClass[category];
      this.setData({
        supplierClass: supplierClass
      });
    }
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
    let { supplierClass, inputData, editSupplierId} = this.data;
    let type = '';
    for (var i in supplierClass) {
      if (supplierClass[i]) {
        type += i.slice(-1) + ';';
      }
    }
    inputData = { ...inputData, type:type}
    //console.log('输入数据',inputData);
    if (editSupplierId != '') {
      //编辑供应商时需要的supplierId加入到参数中
      inputData = { ...inputData, supplierId: editSupplierId }
    }
    if (inputData.supplierName == undefined || inputData.supplierName == "") {
      wx.showToast({
        title: "名称不能为空",
        icon: 'none',
        duration: 2000
      })
      return;
    }
    app.services({
      url: 'saveSupplier',
      method: 'post',
      data: inputData,
      success(result) {
        console.log(result.data);
        let res = result.data;
        if(res.result == 'FAIL') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 800
          });
        }
        if(res.result == 'OK') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          });
          wx.redirectTo({
            url: '../supplierManage/supplierManage',
          })
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
    let supplierClass = { //供应商类别
      option0: false,
      option1: false,
      option2: false,
      option3: false,
      option4: false
    }
    if (options && options.id) {
      wx.setNavigationBarTitle({
        title: '编辑供应商'//页面标题为路由参数
      });
      this.setData({
        editSupplierId: options.id
      });
      app.services({
        url: 'fetchSupplier',
        data: {supplierId: options.id},
        success(result) {
          let res = result.data;
          if(res.result == 'OK') {
            let type = res.supplierVO.type;
            if(type != '') {
              let types = type.split(';');
              for(var i = 0; i<types.length; i++){
                let key = 'option' +types[i];
                supplierClass[key] = true;
              }
            }
            _this.setData({
              inputData: res.supplierVO,
              supplierClass: supplierClass
            });
          }
        }
      });
    }
  },
  delSupplier() {
    let { editSupplierId } = this.data
    app.services({
      url: 'deleteSupplier',
      data: { supplierId: editSupplierId },
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
            url: '../supplierManage/supplierManage',
          })
        }
      },
      loading: true,
      loadingTitle: '正在删除中'
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