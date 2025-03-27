import MyBar from "../components/MyBar"
import { FavoriteManager, FavoriteBook } from '../../common/FavoriteManager';
import promptAction from '@ohos.promptAction';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Collection {
  @State favorites: FavoriteBook[] = []
  private scroller: Scroller = new Scroller()
  
  // 加载收藏数据
  async loadFavorites() {
    this.favorites = await FavoriteManager.getAllFavorites();
  }
  
  // 取消收藏
  async removeFavorite(bookId: number) {
    const success = await FavoriteManager.removeFavorite(bookId);
    if (success) {
      // 重新加载收藏列表
      await this.loadFavorites();
      promptAction.showToast({
        message: '已取消收藏',
        duration: 2000,
      });
    }
  }
  
  // 格式化时间
  formatDate(timestamp: number): string {
    if (!timestamp) return '';
    const date = new Date(timestamp);
    return `${date.getFullYear()}-${date.getMonth() + 1}-${date.getDate()}`;
  }
  
  aboutToAppear() {
    this.loadFavorites();
  }
  
  onPageShow() {
    // 每次页面显示时重新加载收藏数据
    this.loadFavorites();
    // 强制滚动到顶部
    this.scroller.scrollToIndex(0);
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // 顶部背景 - 增加高度
        Column() {
          // 顶部标题 - 增加字体大小
          Text("我的收藏")
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .padding({ left: 20, top: 10, bottom: 20 })
            .width('100%')
            .textAlign(TextAlign.Start)
        }
        .width('100%')
        .height(50)
        .backgroundColor('#FF7878')
        
        // 收藏列表或者空状态
        if (this.favorites.length > 0) {
          // 使用List替代Scroll，更好地控制列表行为
          List({ scroller: this.scroller, initialIndex: 0 }) {
            // 列表项
            ForEach(this.favorites, (item: FavoriteBook) => {
              ListItem() {
                // 收藏卡片外层容器
                Column() {
                  // 卡片主体内容
                  Row() {
                    // 左侧图片部分
                    Column() {
                      Image(item.cover)
                        .width('100%')
                        .height('100%')
                        .objectFit(ImageFit.Cover)
                    }
                    .width('35%')
                    .aspectRatio(0.75)
                    .margin({ right: 15 })
                    .backgroundColor(Color.White)
                    .border({ width: 1.5, color: '#E0E0E0', style: BorderStyle.Solid })
                    
                    // 右侧信息部分
                    Column() {
                      // 漫画标题
                      Text(item.title)
                        .fontSize(19)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#333333')
                        .maxLines(1)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                        .width('100%')
                      
                      // 漫画作者
                      Row({ space: 5 }) {
                        Text("作者:")
                          .fontSize(16)
                          .fontColor('#666666')
                        Text(item.author || "未知")
                          .fontSize(16)
                          .fontColor('#333333')
                          .fontWeight(FontWeight.Medium)
                      }
                      .width('100%')
                      .margin({ top: 8 })
                      
                      // 收藏时间
                      Text(`收藏于: ${this.formatDate(item.updateTime || Date.now())}`)
                        .fontSize(15)
                        .fontColor('#888888')
                        .width('100%')
                        .margin({ top: 8 })
                      
                      // 分割线
                      Divider()
                        .width('100%')
                        .color('#F0F0F0')
                        .margin({ top: 10, bottom: 10 })
                        .strokeWidth(1.5)
                      
                      // 操作按钮
                      Row() {
                        Text("查看详情")
                          .fontSize(15)
                          .fontColor('#FF7878')
                          .fontWeight(FontWeight.Medium)
                          .onClick(() => {
                            router.pushUrl({
                              url: 'pages/Detail',
                              params: {
                                id: item.id
                              }
                            });
                          })
                        
                        Divider()
                          .vertical(true)
                          .height(15)
                          .width(1.5)
                          .margin({ left: 12, right: 12 })
                          .color('#DDDDDD')
                        
                        Text("取消收藏")
                          .fontSize(15)
                          .fontColor('#666666')
                          .fontWeight(FontWeight.Medium)
                          .onClick(() => {
                            this.removeFavorite(item.id);
                          })
                      }
                      .alignItems(VerticalAlign.Center)
                    }
                    .layoutWeight(1)
                    .height('100%')
                    .padding({ top: 10, bottom: 10, left: 8, right: 6 })
                    .alignItems(HorizontalAlign.Start)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .backgroundColor(Color.White)
                  }
                  .width('100%')
                  .height(150)
                }
                .width('92%')
                .backgroundColor(Color.White)
                .borderRadius(6)
                .padding(12)
                .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.15)', offsetX: 0, offsetY: 2 })
              }
              .margin({ top: 8, bottom: 8 })
            })
          }
          .width('100%')
          .layoutWeight(1)
          .divider({ strokeWidth: 0 }) // 移除分隔线
          .scrollBar(BarState.Off)
          .edgeEffect(EdgeEffect.Spring)
          .listDirection(Axis.Vertical)
          .sticky(StickyStyle.None) // 使用正确的枚举值
          .alignListItem(ListItemAlign.Center) // 居中对齐列表项
          .onScrollIndex((firstIndex: number) => {
            console.info('First visible item index: ' + firstIndex);
          })
        } else {
          // 空收藏提示
          Column() {
            Image($r('app.media.collection_1'))
              .width(80)
              .height(80)
              .margin({ bottom: 20 })
            
            Text("暂无收藏内容")
              .fontSize(22)
              .fontColor('#999999')
            
            Text("去首页发现更多精彩漫画吧")
              .fontSize(16)
              .fontColor('#AAAAAA')
              .margin({ top: 10 })
          }
          .width('100%')
          .layoutWeight(1)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
        
        // 底部导航栏
        MyBar({ n: 2 })
          .height('10%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F5F5F5')
    }
    .width('100%')
    .height('100%')
  }
}