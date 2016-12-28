#RGBSimulator
Reflection, Gravity, and Beahavior Simulator 

<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_MOVIE_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_MOVIE_ID_HERE/0.jpg " 
alt="movie on youtube" width=40% border="10" /></a>  
[movie on youtube](https://www.youtube.com/watch?v=YOUTUBE_MOVIE_ID_HERE)  
you must change 3 places "YOUTUBE_MOVIE_ID_HERE" to your same movie id.

Overview of this project.

## Proparation
Explanation.  

* <https://matztada.github.io>  
* [link](https://matztada.github.io)

## Images

<a><img src="https://matztada.github.io/images/logo.jpg" alt="" width=50%></a>  


## 地図から障害物のオブジェクトを作成したい
* 細線化でのバリが出る問題
	* 解消しようとして，直線も消えてしまうこともわかった．
	* でも，逆に言えば，

画像処理の領分  
1. 細線化(ん？でも，今回の対象では境界だけ判断できればいいのかな，いや，やんないとだめだ．)
2. 接続している領域に対して  
3. 端点または頂点を2つ見つける  
4. 見つけた2点間で線分分割
5. 線分分割が完了したら，線分にかかわっている黒い点を白く塗りつぶす