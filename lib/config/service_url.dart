
/*
接口文件
 */

const servcieBaseUrl = 'http://10.150.30.57:8001/shopping/';
//const servcieBaseUrl = 'http://118.26.173.56:8001/shopping/';


const servicePath = {

  'homeBannerContent': servcieBaseUrl +'sysBanner/getReleaseBanners',                   //首页轮播图接口
  'homeRecommendGoodList': servcieBaseUrl + 'sysHomepageProduct/getHomepageProducts',   //首页推荐商品的接口
   //
  'CategoryLeftList' : servcieBaseUrl + 'tProductCategory/getFirstTProductCategory',   //分类左边类的列表
  'CategorytwoThreeDataNet' : servcieBaseUrl + 'tProductCategory/getTProductCategoryByParentId', //分类右两级和三级的数据

};