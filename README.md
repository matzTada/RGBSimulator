# RGBSimulator
Reflection, Gravity, and Beahavior Simulator 

<a href="http://www.youtube.com/watch?feature=player_embedded&v=2gNiQA51ORw
" target="_blank"><img src="http://img.youtube.com/vi/2gNiQA51ORw/0.jpg" 
alt="movie on youtube" width=40% border="10" /></a>  
[movie on youtube](https://www.youtube.com/watch?v=2gNiQA51ORw)  

## 応用
* 人の動き@駅、会議室、学校、ショッピングセンタetc...
* 移動体の動き（船舶、鉄道、タクシー)

## 地図から障害物のオブジェクトを作成したい
* 細線化でのバリが出る問題
	* 解消しようとして，フィルタかけると直線も消えてしまうこともわかった．
	* 逆に考えると，囲まれた空間だけ残るので今回はうれしい．（ポリゴンを作成するため）
* ある程度の解像度が必要っぽい．ThiningとDeburringで消えちゃう

画像処理の領分  
1. 細線化(ん？でも，今回の対象では境界だけ判断できればいいのかな，いや，やんないとだめだ．)
2. 接続している領域に対して  
3. 端点または頂点を2つ見つける  
4. 見つけた2点間で線分分割
5. 線分分割が完了したら，線分にかかわっている黒い点を白く塗りつぶす
