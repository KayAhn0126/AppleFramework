# 4. AppleFramework

- UICollectionView with Storyboard!


## 🍎 작동 화면
|                white                 |                black                 |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/IWfXPva.gif) | ![](https://i.imgur.com/5vvefss.gif) |

## 🍎 Navigation Controller의 Prefers Large Titles

- Prefers Large Titles 미적용
![](https://i.imgur.com/7TsyyWF.png)
- Prefers Large Titles 적용 
![](https://i.imgur.com/Mu9lUlK.png)
- 요즘 앱의 느낌이 물씬 풍긴다.

## 🍎 Label의 numberOfLines를 0으로 두면 텍스트가 표시할 수 있을 만큼 늘어난다

- 해당 lable.bounds 사각형에 최대 라인 수를 정하는 UILabel의 프로퍼티. 기본은 1, 최대 라인 수 해제는 0으로 설정하면 된다.

## 🍎 cell 하나 하나의 사이즈를 정해주는 코드

|                 2열                  |                 3열                  |
|:------------------------------------:|:------------------------------------:|
| ![](https://i.imgur.com/yCXg5Nm.png) | ![](https://i.imgur.com/sOOymsI.png) |

```swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSpacing: CGFloat = 10
    let insetPadding: CGFloat = 16    
    
    let width = (collectionView.bounds.width - itemSpacing * 2 - insetPadding * 2) / 3
    let height = width * 1.5
    
    return CGSize(width: width, height: height)
}
```

- 위의 코드에서 
    - itemSpacing은 cell과 cell 사이에 간격을 10으로 준 것.
    - insetPadding은 화면 좌,우로 부터 간격을 16으로 준 것.

- 비교를 위해 2열로 보여주는 코드. width만 다르고 나머지는 같다.

```swift        
    let width = (collectionView.bounds.width - itemSpacing * 1 - insetPadding * 2) / 2
```
- 한 줄에 보여주고 싶은 cell의 수를 x라고 하자.
- equation of width = (전체 가로 크기 - (cell과 cell 사이 간격 * (x-1)) - (cell의 앞과 뒤 간격)) / (x)
- 즉 셀 하나의 가로는 equation of width, 세로는 equation of width * 1.5 라고 설명 할 수 있다.




## 🍎 collectionView.contentInset의 역할
 
```swift
class FrameworkViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
```
- 위의 cell 하나 하나의 사이즈를 정해주는 코드에서 insetPadding 변수를 이용해 cell 하나하나의 넓이를 구하는데 사용했다.
- 각각의 셀의 넓이를 구하기 위해 insetPadding * 2를 차감한 것 일뿐, 실제로 패딩을 주기 위해서는  컨텐트 뷰의 content 사이즈를 수정해야 함으로 아래와 같이 코드를 추가하면 된다.

```swift
collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
```

## 🍎 ChatList 프로젝트 때 경험한 estimate Size을 코드로 작성하기

먼저 이전 프로젝트 [ChatList](https://github.com/KayAhn0126/ChatList)의 README내 
- **collectionViewCell의 오토 레이아웃이 제대로 잡히지 않는 문제 해결**을 보자!

> - 공식문서에서는 원하는 답변을 찾을 수 없었고 StackOverFlow의 한 유저는 ***xcode 11 이후 부터 UICollectionViewDelegateFlowLayout의 size 결정 메서드가 제대로 동작하려면 Estimate Size 속성을 None으로 바꿔줘야 한다***고 나와있다. [무려 411 따봉을 받은 출처.](https://stackoverflow.com/questions/38028013/how-to-set-uicollectionviewcell-width-and-height-programmatically)

위와 같은 내용을 볼 수 있다. 이번에도 마찬가지로 cell을 이용한 프로젝트 였으므로 아래 사진의 프로세스 같이 cell의 Estimate Size를 None으로 바꿔주었다.

![](https://i.imgur.com/nZFJABW.png)

- 하지만 이것도 코드로 구현 할 수 있다는 것을 이번 프로젝트를 통해 배웠다.
- view를 맨 처음 불러올 때 estimatedItemSize를 .zero로 해주어 동일한 작업을 수행하는 코드.
```swift
class FrameworkViewController: UIViewController {

    var frameworkList: [AppleFramework] = AppleFramework.list
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = .zero
        }
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
```

## 🍎 행과 행 사이, 열과 열 사이 간격 주기
```swift
    // MARK: - 섹션과 섹션 사이의 간격 -> 행과 행 사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // MARK: - 아이템과 아이템 사이의 간격 -> 열과 열 사이의 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
```
