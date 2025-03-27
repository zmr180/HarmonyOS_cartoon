import {banner} from "../../common/iface"
@Component
export default struct MyBanner{
  private swiperController: SwiperController = new SwiperController()
  @Prop arr:Array<banner>
  build() {
    Column({space:5}){
      Swiper(this.swiperController){
        ForEach(this.arr,(item:banner)=>{
          Image(item.pic)
            .borderRadius(10)
            .width("100%")
            // .height(300)
            .fitOriginalSize(true)

        })
      }
      .width("100%")
      .cachedCount(2)
      .index(1)
      .autoPlay(true)
      .interval(5000)
      .indicator(true)
      .loop(true)
      .duration(1000)
      .itemSpace(0)
      .curve(Curve.Linear)
      .padding({left:10,right:10})
      // .margin({top:5})
    }
  }
}