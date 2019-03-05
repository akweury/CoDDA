# CoDDA

复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>
复制本实验时，需要复制整个code文件夹，请不要破坏code文件夹内部的文件树状结构，否则程序将会无法正常运行。<br>

***

CoDDA是本次实验的主要算法<br>
运行环境: Matlab 2015b<br>

点击CoDDA\start_all.m文件运行CoDDA算法<br>
在执行前建议输入命令 warning off 以关闭警告<br>

目前实现了strike，football，livejournal三个数据集<br>
需要那个实验集就取消 %% xxx实验集所涉及的代码注释并运行即可(可在start_all文件中修改)<br>

实验聚类结果储存在CoDDA目录下的cls.txt文件中，按照1-n的顺序存储各个点所属的社区。注意：聚类结果只存储最后一次。<br>

## 实验文件
即start_strike.m, start_football.m, start_livejournal.m三个文件，可以调节以下参数<br>

* maxTimes 实验迭代次数
* 执行哪些实验也是可选择的，使用开关进行管理。1 = on    0 = off
S_shuffle 跳数阈值实验 
sigema_shuffle 衰减因子实验
T_shuffle 稀疏自编码器层数实验
beta_shuffle 惩罚因子权重实验
Lambda_shuffle 权重衰减项

其他参数命名：
k   社区个数
T   深度稀疏自动编码器的层数
d   每层的节点数

S   跳数阈值
sigema  衰减因子

minS  最小跳数阈值
maxS  最大跳数阈值
maxSTimes  跳数阈值迭代次数
minSigema  最小衰减因子的十倍
maxSigema  最大衰减因子的十倍
maxSigemaTimes  衰减因子迭代次数

每个实验文件start_strike.m, start_football.m, start_livejournal.m都会进行两轮实验，每轮实验都是一次完整的过程，但是每轮实验中执行哪些实验是可以选择的。可以自行更改上面的参数。但是注意，第二轮实验之可以更改 执行实验开关，以及迭代次数。但是实验参数无法修改,需要使用第一轮实验的输出参数作为第二轮的输入参数。<br>


## 文件夹dataset保存了实验数据。

data_strike文件夹
	strike.txt 为邻接矩阵
	strikecoordinate.txt为数据集的点坐标，用于显示Matlab图像
	realresult.txt为真实社区
	strike.paj可以使用pajek可视化软件进行可视化。
data_football文件夹
	football_adjacency.txt 为邻接矩阵
		football_coordinate.txt为数据集的点坐标，用于显示Matlab图像
		football_community.txt为真实社区
		其他文件用于pajek可视化软件进行可视化。
	data_livejournal文件夹
		lj_ade.txt是邻接矩阵
		lj_coordinate.txt 为数据集的点坐标，用于显示Matlab图像
		lj_coms.txt为真实社区
		[实验集](http://snap.stanford.edu./data/com-LiveJournal.html)由斯坦福大学提供 本次实验选取其中最大的8个社区一共6368个节点进行聚类，其中big.dataset文件为整个livejournal实验数据集。
	data_orkut文件夹（由于机器能力有限，未参加本次实验）
		orkut_adj.txt是邻接矩阵
		orkut_coms.txt是真实社区
		[实验集](http://snap.stanford.edu./data/com-Orkut.html)由斯坦福大学提供。

<br>

文件夹[mit_network_analysis_tools](http://strategic.mit.edu/downloads.php?page=matlab_networks)是麻省理工学院提供的一个工具包<br><br>

文件夹LPA是LPA算法的Matlab实现，基于2015b版本<br>
