// components
var app = getApp();
Component({
  options: {
    multipleSlots: true // 在组件定义时的选项中启用多slot支持
  },
  /**
   * 组件的属性列表
   * 用于组件自定义设置
   */
  properties: {
    placeholder: {
      type: String,
      value: '输入猪耳号搜索'
    }
  },

  /**
   * 私有数据,组件的初始数据
   * 可用于模版渲染
   */
  data: {
    inputShowed: false,
    inputVal: "",
    inResultView: false,
    pigsList:[]
  },

  /**
   * 组件的方法列表
   * 更新属性和数据的方法与更新页面数据的方法类似
   */
  methods: {
    /*
     * 公有方法
     */
    showInput: function () {
      this.setData({
        inputShowed: true
      });
    },
    hideInput: function () {
      this.setData({
        inputVal: "",
        inputShowed: false
      });
    },
    clearInput: function () {
      this.setData({
        inputVal: ""
      });
    },
    inputTyping: function (e) {
      var that = this;
      app.services({
        url: 'getPigByEarTag',
        data: { earTag: e.detail.value },
        complete: function (result) {
          console.log(result);
          var temp = "";
          if (result.data.pigsList.length>0){
            temp = 1;
          }
          that.setData({           
            inResultView: temp,
            pigsList:result.data.pigsList
          });
        }
      });

      that.setData({
        inputVal: e.detail.value
      });
      //console.log(e.detail.value);
    },
    /*
    * 内部私有方法建议以下划线开头
    * triggerEvent 用于触发事件
    */
    _searchHandle(e) {
      this.triggerEvent("searchHandleEvent", { value: e.currentTarget.dataset.pigsid });
      this.setData({
        inResultView: false
      });
    }
  }
})