layout: post
date: 2015/02/27
keywords: 工作
title: Vim按键说明
categories: [Linux]
tags: [vim]
---



<ul class="list1"><li>第一部份：一般模式可用的按钮说明，光标移动、复制贴上、搜寻取代等</li></ul>
<div class="fontwidth">
<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">移动光标的方法</font></td></tr>
	<tr><td style="text-align: center;" width="180">h 或 向左箭头键(←)</td>
		<td>光标向左移动一个字符</td></tr>
	<tr><td style="text-align: center;">j 或 向下箭头键(↓)</td>
		<td>光标向下移动一个字符</td></tr>
	<tr><td style="text-align: center;">k 或 向上箭头键(↑)</td>
		<td>光标向上移动一个字符</td></tr>
	<tr><td style="text-align: center;">l 或 向右箭头键(→)</td>
		<td>光标向右移动一个字符</td></tr>
	<tr><td colspan="2">
		如果你将右手放在键盘上的话，你会发现 hjkl 是排列在一起的，因此可以使用这四个按钮来移动光标。
		如果想要进行多次移动的话，例如向下移动 30 行，可以使用 "30j" 或 "30↓" 的组合按键，
		亦即加上想要进行的次数(数字)后，按下动作即可！</td></tr>
	<tr><td style="text-align: center;">[Ctrl] + [f]</td>
		<td>屏幕『向下』移动一页，相当于 [Page Down]按键
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">[Ctrl] + [b]</td>
		<td>屏幕『向上』移动一页，相当于 [Page Up] 按键
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">[Ctrl] + [d]</td>
		<td>屏幕『向下』移动半页</td></tr>
	<tr><td style="text-align: center;">[Ctrl] + [u]</td>
		<td>屏幕『向上』移动半页</td></tr>
	<tr><td style="text-align: center;">+</td>
		<td>光标移动到非空格符的下一列</td></tr>
	<tr><td style="text-align: center;">-</td>
		<td>光标移动到非空格符的上一列</td></tr>
	<tr><td style="text-align: center;">n&lt;space&gt;</td>
		<td>那个 n 表示『数字』，例如 20 。按下数字后再按空格键，光标会向右移动这一行的 n
		个字符。例如 20&lt;space&gt; 则光标会向后面移动 20 个字符距离。</td></tr>
	<tr><td style="text-align: center;">0 或功能键[Home]</td>
		<td>这是数字『 0 』：移动到这一行的最前面字符处
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">$ 或功能键[End]</td>
		<td>移动到这一行的最后面字符处(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">H</td>
		<td>光标移动到这个屏幕的最上方那一行的第一个字符</td></tr>
	<tr><td style="text-align: center;">M</td>
		<td>光标移动到这个屏幕的中央那一行的第一个字符</td></tr>
	<tr><td style="text-align: center;">L</td>
		<td>光标移动到这个屏幕的最下方那一行的第一个字符</td></tr>
	<tr><td style="text-align: center;">G</td>
		<td>移动到这个档案的最后一行(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">nG</td>
		<td>n 为数字。移动到这个档案的第 n 行。例如 20G 则会移动到这个档案的第 20 
		行(可配合 :set nu)</td></tr>
	<tr><td style="text-align: center;">gg</td>
		<td>移动到这个档案的第一行，相当于 1G 啊！
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">n&lt;Enter&gt;</td>
		<td>n 为数字。光标向下移动 n 行(<span class="text_import2">常用</span>)</td></tr>
<tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">搜寻与取代</font></td></tr>
	<tr><td style="text-align: center;">/word</td>
		<td>向光标之下寻找一个名称为 word 的字符串。例如要在档案内搜寻 vbird 
		这个字符串，就输入 /vbird 即可！
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">?word</td>
		<td>向光标之上寻找一个字符串名称为 word 的字符串。</td></tr>
	<tr><td style="text-align: center;">n</td>
		<td>这个 n 是英文按键。代表『<u>重复前一个搜寻的动作</u>』。举例来说，
		如果刚刚我们执行 /vbird 去向下搜寻 vbird 这个字符串，则按下 n 后，会向下继续搜寻下一个名称为 vbird 
		的字符串。如果是执行 ?vbird 的话，那么按下 n 则会向上继续搜寻名称为 vbird 的字符串！</td></tr>
	<tr><td style="text-align: center;">N</td>
		<td>这个 N 是英文按键。与 n 刚好相反，为『反向』进行前一个搜寻动作。
		例如 /vbird 后，按下 N 则表示『向上』搜寻 vbird 。</td></tr>
	<tr><td colspan="2">
		使用 /word 配合 n 及 N 是非常有帮助的！可以让你重复的找到一些你搜寻的关键词！
	</td></tr>
	<tr><td style="text-align: center;">:n1,n2s/word1/word2/g</td>
		<td>n1 与 n2 为数字。在第 n1 与 n2 行之间寻找 word1 这个字符串，并将该字符串取代为
		word2 ！举例来说，在 100 到 200 行之间搜寻 vbird 并取代为 VBIRD 则：<br>
		『:100,200s/vbird/VBIRD/g』。(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">:1,$s/word1/word2/g</td>
		<td>从第一行到最后一行寻找 word1 字符串，并将该字符串取代为
		word2 ！(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">:1,$s/word1/word2/gc</td>
		<td>从第一行到最后一行寻找 word1 字符串，并将该字符串取代为
		word2 ！且在取代前显示提示字符给用户确认 (confirm)
		是否需要取代！(<span class="text_import2">常用</span>)</td></tr>
<tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">删除、复制与贴上</font></td></tr>
	<tr><td style="text-align: center;">x, X</td>
		<td>在一行字当中，x 为向后删除一个字符 (相当于 [del] 按键)，
		 X 为向前删除一个字符(相当于 [backspace] 亦即是退格键)
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">nx</td>
		<td>n 为数字，连续向后删除 n 个字符。举例来说，我要连续删除 10 个字符，
		『10x』。</td></tr>
	<tr><td style="text-align: center;">dd</td>
		<td>删除游标所在的那一整列(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">ndd</td>
		<td>n 为数字。删除光标所在的向下 n 列，例如 20dd 则是删除 20 列
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">d1G</td>
		<td>删除光标所在到第一行的所有数据</td></tr>
	<tr><td style="text-align: center;">dG</td>
		<td>删除光标所在到最后一行的所有数据</td></tr>
	<tr><td style="text-align: center;">d$</td>
		<td>删除游标所在处，到该行的最后一个字符</td></tr>
	<tr><td style="text-align: center;">d0</td>
		<td>那个是数字的 0 ，删除游标所在处，到该行的最前面一个字符</td></tr>
	<tr><td style="text-align: center;">yy</td>
		<td>复制游标所在的那一行(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">nyy</td>
		<td>n 为数字。复制光标所在的向下 n 列，例如 20yy 则是复制 20
		列(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">y1G</td>
		<td>复制游标所在列到第一列的所有数据</td></tr>
	<tr><td style="text-align: center;">yG</td>
		<td>复制游标所在列到最后一列的所有数据</td></tr>
	<tr><td style="text-align: center;">y0</td>
		<td>复制光标所在的那个字符到该行行首的所有数据</td></tr>
	<tr><td style="text-align: center;">y$</td>
		<td>复制光标所在的那个字符到该行行尾的所有数据</td></tr>
	<tr><td style="text-align: center;">p, P</td>
		<td>p 为将已复制的数据在光标下一行贴上，P 则为贴在游标上一行！
		举例来说，我目前光标在第 20 行，且已经复制了 10 行数据。则按下 p 后，
		那 10 行数据会贴在原本的 20 行之后，亦即由 21 行开始贴。但如果是按下 P 呢？
		那么原本的第 20 行会被推到变成 30 行。
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">J</td>
		<td>将光标所在列与下一列的数据结合成同一列</td></tr>
	<tr><td style="text-align: center;">c</td>
		<td>重复删除多个数据，例如向下删除 10 行，[ 10cj ]</td></tr>
	<tr><td style="text-align: center;">u</td>
		<td>复原前一个动作。(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">[Ctrl]+r</td>
		<td>重做上一个动作。(<span class="text_import2">常用</span>)</td></tr>
	<tr><td colspan="2">这个 u 与 [Ctrl]+r 是很常用的指令！一个是复原，另一个则是重做一次～
		利用这两个功能按键，你的编辑，嘿嘿！很快乐的啦！</td></tr>
	<tr><td style="text-align: center;">.</td>
		<td>不要怀疑！这就是小数点！意思是重复前一个动作的意思。
		如果你想要重复删除、重复贴上等等动作，按下小数点『.』就好了！
		(<span class="text_import2">常用</span>)</td></tr>
	</tbody></table><br>

		<hr><ul class="list1"><li class="text_import1">第二部份：一般模式切换到编辑模式的可用的按钮说明</li></ul><br>

<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">进入插入或取代的编辑模式</font></td></tr>
	<tr><td style="text-align: center;" width="120">i, I</td>
		<td>进入插入模式(Insert mode)：<br>
		i 为『从目前光标所在处插入』， I 为『在目前所在行的第一个非空格符处开始插入』。
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">a, A</td>
		<td>进入插入模式(Insert mode)：<br>
		a 为『从目前光标所在的下一个字符处开始插入』， A
		为『从光标所在行的最后一个字符处开始插入』。(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">o, O</td>
		<td>进入插入模式(Insert mode)：<br>
		这是英文字母 o 的大小写。o 为『在目前光标所在的下一行处插入新的一行』；
		O 为在目前光标所在处的上一行插入新的一行！(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">r, R</td>
		<td>进入取代模式(Replace mode)：<br>
		r 只会取代光标所在的那一个字符一次；R会一直取代光标所在的文字，直到按下
		ESC 为止；(<span class="text_import2">常用</span>)</td></tr>
	<tr><td colspan="2">上面这些按键中，在 vi 画面的左下角处会出现『--INSERT--』或『--REPLACE--』的字样。
		由名称就知道该动作了吧！！特别注意的是，我们上面也提过了，你想要在档案里面输入字符时，
		一定要在左下角处看到 INSERT 或 REPLACE 才能输入喔！</td></tr>
	<tr><td style="text-align: center;">[Esc]</td>
		<td>退出编辑模式，回到一般模式中(<span class="text_import2">常用</span>)</td></tr>
	</tbody></table><br>

		<hr><ul class="list1"><li class="text_import1">第三部份：一般模式切换到指令列模式的可用的按钮说明</li></ul><br>

<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">指令列的储存、离开等指令</font></td></tr>
	<tr><td style="text-align: center;" width="160">:w</td>
		<td>将编辑的数据写入硬盘档案中(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">:w!</td>
		<td>若文件属性为『只读』时，强制写入该档案。不过，到底能不能写入，
		还是跟你对该档案的档案权限有关啊！</td></tr>
	<tr><td style="text-align: center;">:q</td>
		<td>离开 vi (<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">:q!</td>
		<td>若曾修改过档案，又不想储存，使用 ! 为强制离开不储存档案。</td></tr>
	<tr><td colspan="2">注意一下啊，那个惊叹号 (!) 在 vi 当中，常常具有『强制』的意思～</td></tr>
	<tr><td style="text-align: center;">:wq</td>
		<td>储存后离开，若为 :wq! 则为强制储存后离开
		(<span class="text_import2">常用</span>)</td></tr>
	<tr><td style="text-align: center;">ZZ</td>
		<td>这是大写的 Z 喔！若档案没有更动，则不储存离开，若档案已经被更动过，则储存后离开！</td></tr>
	<tr><td style="text-align: center;">:w [filename]</td>
		<td>将编辑的数据储存成另一个档案（类似另存新档）</td></tr>
	<tr><td style="text-align: center;">:r [filename]</td>
		<td>在编辑的数据中，读入另一个档案的数据。亦即将 『filename』
		这个档案内容加到游标所在行后面</td></tr>
	<tr><td style="text-align: center;">:n1,n2 w [filename]</td>
		<td>将 n1 到 n2 的内容储存成 filename 这个档案。</td></tr>
	<tr><td style="text-align: center;">:! command</td>
		<td>暂时离开 vi 到指令列模式下执行 command 的显示结果！例如<br>
		『:! ls /home』即可在 vi 当中察看 /home 底下以 ls 输出的档案信息！</td></tr>
<tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">vim 环境的变更</font></td></tr>
	<tr><td style="text-align: center;">:set nu</td>
		<td>显示行号，设定之后，会在每一行的前缀显示该行的行号</td></tr>
	<tr><td style="text-align: center;">:set nonu</td>
		<td>与 set nu 相反，为取消行号！</td></tr>
</tbody></table><br>
</div>
<div class="fontwidth">
<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">区块选择的按键意义</font></td></tr>
	<tr><td style="text-align: center;">v</td><td>字符选择，会将光标经过的地方反白选择！</td></tr>
	<tr><td style="text-align: center;">V</td><td>行选择，会将光标经过的行反白选择！</td></tr>
	<tr><td style="text-align: center;">[Ctrl]+v</td><td>区块选择，可以用长方形的方式选择资料</td></tr>
	<tr><td style="text-align: center;">y</td><td>将反白的地方复制起来</td></tr>
	<tr><td style="text-align: center;">d</td><td>将反白的地方删除掉</td></tr>
</tbody></table><br>
</div>
<div class="fontwidth">
<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">多档案编辑的按键</font></td></tr>
	<tr><td style="text-align: center;">:n</td><td>编辑下一个档案</td></tr>
	<tr><td style="text-align: center;">:N</td><td>编辑上一个档案</td></tr>
	<tr><td style="text-align: center;">:files</td><td>列出目前这个 vim 的开启的所有档案</td></tr>
</tbody></table><br>
</div>
<div class="fontwidth">
<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">多窗口情况下的按键功能</font></td></tr>
	<tr><td style="text-align: center;" width="150">:sp [filename]</td><td>开启一个新窗口，如果有加 filename，
		表示在新窗口开启一个新档案，否则表示两个窗口为同一个档案内容(同步显示)。</td></tr>
	<tr><td style="text-align: center;">[ctrl]+w+ j<br>[ctrl]+w+↓</td><td>按键的按法是：先按下 [ctrl] 不放，
		再按下 w 后放开所有的按键，然后再按下 j (或向下箭头键)，则光标可移动到下方的窗口。</td></tr>
	<tr><td style="text-align: center;">[ctrl]+w+ k<br>[ctrl]+w+↑</td><td>同上，不过光标移动到上面的窗口。</td></tr>
	<tr><td style="text-align: center;">[ctrl]+w+ q</td><td>其实就是 :q 结束离开啦！
		举例来说，如果我想要结束下方的窗口，那么利用 [ctrl]+w+↓ 移动到下方窗口后，按下 :q 即可离开，
		也可以按下 [ctrl]+w+q 啊！</td></tr>
</tbody></table>
</div>
<div class="fontwidth">
<table bgcolor="lightyellow" border="1" cellpadding="3" cellspacing="0" width="95%">
<tbody><tr bgcolor="#182448"><td colspan="2" style="color: rgb(0, 0, 136); font-size: 1.1em; text-align: center;"><font color="#FFFFFF">vim 的环境设定参数</font></td></tr>
	<tr><td style="text-align: center;" width="170">:set nu<br>:set nonu</td><td>就是设定与取消行号啊！</td></tr>
	<tr><td style="text-align: center;">:set hlsearch<br>:set nohlsearch</td><td>hlsearch 就是 high light search(高亮度搜寻)。
		这个就是设定是否将搜寻的字符串反白的设定值。默认值是 hlsearch</td></tr>
	<tr><td style="text-align: center;">:set autoindent<br>:set noautoindent</td><td>是否自动缩排？autoindent 就是自动缩排。</td></tr>
	<tr><td style="text-align: center;">:set backup</td><td>是否自动储存备份档？一般是 nobackup 的，
		如果设定 backup 的话，那么当你更动任何一个档案时，则源文件会被另存成一个档名为 filename~ 的档案。
		举例来说，我们编辑 hosts ，设定 :set backup ，那么当更动 hosts 时，在同目录下，就会产生 hosts~ 
		文件名的档案，记录原始的 hosts 档案内容</td></tr>
	<tr><td style="text-align: center;">:set ruler</td><td>还记得我们提到的右下角的一些状态栏说明吗？
		这个 ruler 就是在显示或不显示该设定值的啦！</td></tr>
	<tr><td style="text-align: center;">:set showmode</td><td>这个则是，是否要显示 --INSERT-- 
		之类的字眼在左下角的状态栏。</td></tr>
	<tr><td style="text-align: center;">:set backspace=(012)</td><td>一般来说，
		如果我们按下 i 进入编辑模式后，可以利用退格键 (backspace) 来删除任意字符的。
		但是，某些 distribution 则不许如此。此时，我们就可以透过 backspace 来设定啰～
		当 backspace 为 2 时，就是可以删除任意值；0 或 1 时，仅可删除刚刚输入的字符，
		而无法删除原本就已经存在的文字了！</td></tr>
	<tr><td style="text-align: center;">:set all</td><td>显示目前所有的环境参数设定值。</td></tr>
	<tr><td style="text-align: center;">:set</td><td>显示与系统默认值不同的设定参数，
		一般来说就是你有自行变动过的设定参数啦！</td></tr>
	<tr><td style="text-align: center;">:syntax on<br>:syntax off</td><td>是否依据程序相关语法显示不同颜色？
		举例来说，在编辑一个纯文本档时，如果开头是以 # 开始，那么该行就会变成蓝色。
		如果你懂得写程序，那么这个 :syntax on 还会主动的帮你除错呢！但是，
		如果你仅是编写纯文本档案，要避免颜色对你的屏幕产生的干扰，则可以取消这个设定 。</td></tr>
	<tr><td style="text-align: center;">:set bg=dark<br>:set bg=light</td><td>
		可用以显示不同的颜色色调，预设是『 light 』。如果你常常发现批注的字体深蓝色实在很不容易看，
		那么这里可以设定为 dark 喔！试看看，会有不同的样式呢！</td></tr>
</tbody></table>
</div>