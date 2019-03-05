复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>

***
# 基于深度学习的社区发现算法实现与对比

> 社区发现是一项用于理解现实世界众多的网络结构的重要方法。复杂网络往往具有社区结构，传统的聚类方法诸如 k-means 只能在小数据集或结构规律的网络中进行社区发现，对于大规模复杂数据集则无法有效发现社区。本实验实现了一 种在使用传统聚类算法的基础上，进一步通过深度学习来提高聚类精度的算法。在实验中通过构建了一种能够显示节点 之间间接联系的相似度矩阵，并进一步使用了基于无监督学习的方式构建深度稀疏自动编码器进行降维，提取网络中的 特征结构，提取得到的结果再使用k-means 进行聚类，最终得到社区。多次实验取得的平均结果显示，相似度矩阵具有 比邻接矩阵更好的聚类结果，在使用相似度矩阵的基础上使用深度稀疏自动编码器可以进一步提高在大数据集上的聚类准确度。

CoDDA是本次实验的主要算法，根据文章[基于深度稀疏自动编码器的社区发现算法](http://www.cnki.net/kcms/detail/11.2560.TP.20161129.1335.017.html)一文实现<br>
>*运行环境: Matlab 2015b*
>*操作系统: Windows Server 2012 R2*
>*运行内存: 64G* 

>点击CoDDA\start_all.m文件运行CoDDA算法<br>
>在执行前建议输入命令 warning off 以关闭警告<br>

目前实现了strike，football，livejournal三个数据集<br>
需要那个实验集就取消 %% xxx实验集所涉及的代码注释并运行即可(可在start_all文件中修改)<br>

实验聚类结果储存在CoDDA目录下的cls.txt文件中，按照1-n的顺序存储各个点所属的社区。注意：聚类结果只存储最后一次。<br>

## 实验文件
即start_strike.m, start_football.m, start_livejournal.m三个文件，可以调节以下参数<br>

* maxTimes 实验迭代次数
* 执行哪些实验也是可选择的，使用开关进行管理。1 = on  0 = off，其中：
	* S_shuffle 		跳数阈值实验 
	* sigema_shuffle 	衰减因子实验
	* T_shuffle 		稀疏自编码器层数实验
	* beta_shuffle 		惩罚因子权重实验
	* Lambda_shuffle 	权重衰减项
* 其他参数
	* k 				社区个数
	* T   				深度稀疏自动编码器的层数
	* d 				每层的节点数

	* S   				跳数阈值
	* sigema  			衰减因子

	* minS  			最小跳数阈值
	* maxS  			最大跳数阈值
	* maxSigemaTimes 	跳数阈值迭代次数
	* minSigema  		最小衰减因子的十倍
	* maxSigema  		最大衰减因子的十倍
	* maxSigemaTimes  	衰减因子迭代次数

每个实验文件start_strike.m, start_football.m, start_livejournal.m都会进行**两轮实验**，每轮实验都是一次完整的过程，但是每轮实验中执行哪些实验是可以选择的。可以自行更改上面的参数。<br>

注意：第二轮实验之可以更改执行实验开关，以及迭代次数。但是实验参数无法修改,需要使用第一轮实验的输出参数作为第二轮的输入参数。<br>


## 实验数据
实验数据保存在dataset文件夹中<br>

* data_strike文件夹
	* strike.txt 为邻接矩阵
	* strikecoordinate.txt为数据集的点坐标，用于显示Matlab图像
	* realresult.txt为真实社区
	* strike.paj可以使用pajek可视化软件进行可视化。
* data_football文件夹
	* football_adjacency.txt 为邻接矩阵
	* football_coordinate.txt为数据集的点坐标，用于显示Matlab图像
	* football_community.txt为真实社区
	* 其他文件用于[pajek](http://vlado.fmf.uni-lj.si/pub/networks/Pajek/)可视化软件进行可视化。
* data_livejournal文件夹
	* lj_ade.txt是邻接矩阵
	* lj_coordinate.txt 为数据集的点坐标，用于显示Matlab图像
	* lj_coms.txt为真实社区
	* [实验集](http://snap.stanford.edu./data/com-LiveJournal.html)由斯坦福大学提供 本次实验选取其中最大的8个社区一共6368个节点进行聚类，其中big.dataset文件为整个livejournal实验数据集。
* data_orkut文件夹（由于机器能力有限，未参加本次实验）
	* orkut_adj.txt是邻接矩阵
	* orkut_coms.txt是真实社区
	* [实验集](http://snap.stanford.edu./data/com-Orkut.html)由斯坦福大学提供。
<br>

##### 文件夹[mit_network_analysis_tools](http://strategic.mit.edu/downloads.php?page=matlab_networks)是麻省理工学院提供的一个工具包<br><br>

##### 文件夹LPA是LPA算法的Matlab实现，基于2015b版本<br>
