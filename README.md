# BoxOffice

| 일별 랭킹페이지 | 상세정보 페이지 | 공유 페이지 |
| ---------------- | ---------------- | ---------------- |
|![](https://user-images.githubusercontent.com/73588175/197400984-8c34d5e4-47bc-4e28-9ac7-5c21b8cc98ab.gif)|![](https://user-images.githubusercontent.com/73588175/197400990-7271abf0-72c0-4a19-80b5-9540f8e54eb9.gif)|![](https://user-images.githubusercontent.com/73588175/197400995-a088f4c4-0e2f-4bf6-9c0f-6a77307fc8fd.gif)|

<br>
<br>

# Feature
### Utilities
- **URLManager**: 필요한 url을 생성함
- **APIManager**: url을 이용해 JSON 데이터를 받음
- **ParseManager**: JSON 데이터를 decoding 
- **MovieDataManager**: response를 각 controller에 맞게 필요한 **타입**으로 변환
- **CacheManager**: 같은 이미지를 여러 번 받아오지 않도록 캐싱 
- **ShareManager**: 공유할 컨텐츠를 이미지로 변환
<br>

### Models
- **KobisResponse**: 일별 랭킹 정보를 담을 response 모델
- **TmdbResponse**: 영화의 포스터이미지, 배경이미지, 줄거리, 트레일러 정보를 담을 response 모델
- **Section**: section 모델
- **Item**: item 모델
<br>

### ViewControllers
- **DailyRankingViewController**
- **DetailViewController**
    - 줄거리 섹션의 셀을 터치하면 전체내용이 보인다.
<br>

### Views
- **RankingView**
    - Cell
    - SupplementaryItem
- **DetailView**
    - Cell
    - SupplementaryItem
<br>
<br>

# 고민한 점
### 첫번째 페이지와 두번째 페이지의 모델관리
1. kobis api에 영화순위와 함께 영화의 메인정보 요청<br>
2. 응답받은 데이터의 영화코드로 상세정보 요청<br>
3. 응답받은 데이터의 영화이름으로 영화 id, poster, backdrop, 줄거리 요청<br>

의 순으로 데이터를 받는다.<br>
이 때 받은 데이터를 첫번째 페이지(랭킹 페이지)에서 쉽게 쓸 수 있게 가공하는데, <br>
두 번째 페이지에도 거의 모든 정보가 똑같이 쓰인다.<br>
<br>
하지만 섹션을 트레일러섹션, 줄거리섹션, 상세정보섹션으로 나눠서 한 정보로 세 개의 셀을 만들기 떄문에 만약 같은 모델로 사용한다면 sanpshot이 같은 정보를 세 번 업데이트하는 꼴이 된다.<br>
그렇다고 한 모델을 다시 세 개의 모델로 나누는 것은 괜찮은 건가? 라는 생각이 들었다.<br>
아직 diffable data source에 대한 이해가 부족하고 많이 이용해보지 못해 생각보다 까다로웠다.<br>
이제와서 든 생각이지만, <br>
많은 변화가 있는 앱이 아닌 이상 굳이 diffable data source를 쓸 이유가 있을까? 싶다.  
<br>
<br>

### 컬렉션셀의 동적 높이적용
분명 [apple에서 소개하고 있는 예제](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views)를 참고해서 적용했는데,
```swift
func createLayout() -> UICollectionViewLayout {
    let estimatedHeight = CGFloat(100)
    let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .estimated(estimatedHeight))
    let item = NSCollectionLayoutItem(layoutSize: layoutSize)
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,
                                                   subitem: item,
                                                   count: 1)
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    section.interGroupSpacing = 10
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
}
```
내 컬렉션뷰에는 적용되지 않았다. 이유는 estimate를 적용하고 싶다면,  
셀과 연결된 컨텐츠의 leading, trailing, top, bottom의 constraints를 정확히 주어야 했는데 bottom 대신 비율만 줬기 때문이었다.(컬렉션뷰셀에는 contentView가 없다!)   
호오😉
