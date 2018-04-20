var app = getApp();
var sliderWidth = 96; // 需要设置slider的宽度，用于计算中间位置
var boars = ['驻场', '引入',];
var boars5 = ['公', '母'];
var boars6 = ['1', '2', '3', '4'];
Page({
  data: {
    tabs: ["公猪", "母猪", "仔猪"],
    activeIndex: 1,
    sliderOffset: 0,
    sliderLeft: 0,
    boars,
    boars5,
    boars6,
    selectBoar0: true,
    selectBoar1: true,
    selectBoar2: true,
    selectBoar3: true,
    selectBoar4: true,
    selectBoar5: true,
    firstBoar: '选择来源类型',
    secondBoar: 0,
    threeBoar: 0,
    fourBoar: 0, //选中的猪舍下标
    fiveBoar: '选择种猪性别',
    sixBoar: '0',
    selectArea: false,
    date: '',
    pigIndate: '',

    pigCategoryList: [],
    pigStrainList: [],
    farmVO: [],
    earTagVal: '',
  },
  clickBoar: function (e) {
    var _this = this;
    var way = e.target.dataset.way;
    this.setData({
      selectBoar0: true,
      selectBoar1: true,
      selectBoar2: true,
      selectBoar3: true,
      selectBoar4: true,
      selectBoar5: true,
    });
    if (way === 'undefined') {
      return;
    }
    else if (way == '0') {
      this.setData({
        selectBoar0: !this.data.selectBoar0
      });
    }
    else if (way == '1') {
      this.setData({
        selectBoar1: false
      })
      //this.setData({
      // selectBoar1: !this.data.selectBoar1
      //});
    }
    else if (way == '2') {
      var categoryId = this.data.pigCategoryList[this.data.secondBoar].categoryId;
      app.services({
        url: 'queryPigStrain',
        data: { categoryId: categoryId },
        success: function (result) {
          var res = result.data;
          if (res.result == 'OK') {
            _this.setData({
              pigStrainList: res.pigStrainList,
              selectBoar2: false
            })
          }
        }
      })
      //this.setData({
      //selectBoar2: !this.data.selectBoar2
      //});
    }
    else if (way == '3') {
      this.setData({
        selectBoar3: false
      })
    }
    else if (way == '4') {
      this.setData({
        selectBoar4: !this.data.selectBoar4
      });
    }
    else if (way == '5') {
      this.setData({
        selectBoar5: !this.data.selectBoar5
      });
    }
  },
  //点击切换
  mySelect: function (e) {
    var _this = this;
    var type = e.target.dataset.type;
    var me = e.target.dataset.me;
    var rank = e.target.dataset.rank;
    var room = e.target.dataset.room;
    var sex = e.target.dataset.sex;
    var parity = e.target.dataset.parity;
    if (type !== undefined) {
      this.setData({
        firstBoar: type,
        selectBoar0: true
      })
    }
    if (me !== undefined) {
      this.setData({
        secondBoar: me,
        selectBoar1: true
      })
      _this.setData({
        pigStrainList: [],
      })
    }
    if (rank !== undefined) {
      this.setData({
        threeBoar: rank,
        selectBoar2: true
      })
    }
    if (room !== undefined) {
      this.setData({
        fourBoar: room,
        selectBoar3: true
      })
    }
    if (sex !== undefined) {
      this.setData({
        fiveBoar: sex,
        selectBoar4: true
      })
    }
    if (parity !== undefined) {
      this.setData({
        sixBoar: parity,
        selectBoar5: true
      })
    }
  },
  saveAdd() {
    var categoryId = this.data.pigCategoryList[this.data.secondBoar].categoryId;
    if (this.data.pigStrainList[this.data.threeBoar] == undefined || this.data.pigStrainList[this.data.threeBoar] == "") {
      wx.showToast({
        title: "请选择品系",
        icon: 'none',
        duration: 2000
      })
      return;
    }
    var strainId = this.data.pigStrainList[this.data.threeBoar].strainId;
    var penId = this.data.farmVO[this.data.fourBoar].penId;
    /*  var birthday = this.data.date;
     var earTagVal = this.data.earTagVal;*/
    let { date, earTagVal, activeIndex, pigIndate, fiveBoar, pigId, today } = this.data;
    var data = {
      categoryId,
      strainId,
      penId,
      birthday: date,
      earTag: earTagVal,
      sexType: activeIndex,
      admissionDate: pigIndate,
    }
    if (activeIndex == '2' && fiveBoar == '1') { //母仔猪
      data.sexType = '3';
    }
    if (pigId) {
      data.pigsId = pigId;
    }
    if (earTagVal == undefined || earTagVal == "") {
      wx.showToast({
        title: "耳标不能为空",
        icon: 'none',
        duration: 2000
      })
      return;
    }
    //console.log(data);
    app.services({
      url: 'savePig',
      data: data,
      method: 'post',
      success(result) {
        let res = result.data;
        //console.log(res);
        if (res.result == 'OK') {
          wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          })
          //创建成功后跳转
          wx.switchTab({
            url: '../pigs/pigs',
          })
        } else if (res.result == 'FAIL'){
          wx.showToast({
            title: res.msg,
            icon: 'none',
            duration: 2000
          })
        }
      }
    });
  },
  onLoad: function (options) {
    var that = this;
    wx.getSystemInfo({
      success: function (res) {
        that.setData({
          sliderLeft: (res.windowWidth / that.data.tabs.length - sliderWidth) / 2,
          sliderOffset: res.windowWidth / that.data.tabs.length * that.data.activeIndex
        });
      }
    });
    //请求猪品种
    app.services({
      url: 'queryPigCategory',
      success: function (result) {
        var res = result.data;
        if (res.result == 'OK') {
          that.setData({
            pigCategoryList: res.pigCategoryList
          })
        }
      }
    })
    //请求猪舍
    app.services({
      url: 'queryPen',
      success: function (result) {
        var res = result.data;
        if (res.result == 'OK') {
          that.setData({
            farmVO: res.farmVO
          })
        }
      }
    })
    //修改猪
    if (options.pigid) {
      this.setData({
        pigId: options.pigid
      });
      wx.setNavigationBarTitle({
        title: '编辑猪只'//页面标题为路由参数
      });
      app.services({
        url: 'fetchPig',
        data: { pigsId: options.pigid },
        complete: function (result) {
          let res = result.data;
          console.log(res);
          //处理数据
          let pig = res.pigsVO;
          pig.admissionDate = pig.admissionDate.substring(0, 10);
          pig.birthday = pig.birthday.substring(0, 10);
          let { pigCategoryList, farmVO } = that.data;
          for (var i = 0, secondBoar = 0; i < pigCategoryList.length; i++) {
            if (pigCategoryList[i].categoryId == pig.categoryId) {
              secondBoar = i;
              break;
            }
          }
          for (var i = 0, fourBoar = 0; i < farmVO.length; i++) {
            if (farmVO[i].penId == pig.penId) {
              fourBoar = i;
              break;
            }
          }
          //请求猪品系
          app.services({
            url: 'queryPigStrain',
            data: { categoryId: pig.categoryId },
            success: function (result) {
              var res = result.data;
              if (res.result == 'OK') {
                for (var i = 0, threeBoar = 0; i < res.pigStrainList.length; i++) {
                  if (res.pigStrainList[i].strainId == pig.strainId) {
                    that.setData({
                      pigStrainList: res.pigStrainList,
                      threeBoar: i
                    })
                    break;
                  }
                }
              }
            }
          })

          that.setData({
            earTagVal: pig.earTag,
            date: pig.birthday,
            pigIndate: pig.admissionDate,
            activeIndex: pig.sexType == '3' ? '2' : pig.sexType,
            fiveBoar: pig.sexType == '2' ? '0' : pig.sexType == '3' ? '1' :'选择种猪性别',
            secondBoar,
            fourBoar,
          });
          wx.hideToast();//关闭loading提示
        },
        loading: true,
        loadingTitle: '正在获取数据'
      });
    }

    var date = new Date();
    var year = date.getFullYear(); //获取完整的年份(4位,1970-????)
    var month = date.getMonth() + 1; //获取当前月份(0-11,0代表1月)
    var date1 = date.getDate(); //获取当前日(1-31)
    if (month<10){
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
  tabClick: function (e) {
    if(this.data.pigId) {
      return;
    }
    this.setData({
      sliderOffset: e.currentTarget.offsetLeft,
      activeIndex: e.currentTarget.id,
      selectBoar0: true,
      selectBoar1: true,
      selectBoar2: true,
      selectBoar3: true,
      selectBoar4: true,
      selectBoar5: true,
    });
  },
  bindDateChange(e) {
    this.setData({
      date: e.detail.value
    });
  },
  bindPigInDateChange(e) {
    this.setData({
      pigIndate: e.detail.value
    });
    if (this.data.date > e.detail.value){
      this.setData({
        date: e.detail.value
      });
    }
  },
  getEarTag(event) {
    var value = event.detail.value;
    this.setData({
      earTagVal: value
    });
  },
  delPig() {
    let { pigId } = this.data
    app.services({
      url: 'deletePig',
      data: { pigsId: pigId },
      success(result) {
        let res = result.data;
        if (res.result == 'OK') {
          wx.hideToast();
          wx.showToast({
            title: res.msg,
            icon: 'success',
            duration: 800
          });
          wx.switchTab({
            url: '../pigs/pigs',
          })
        }
      },
      loading: true,
      loadingTitle: '正在删除中'
    });
  },
});