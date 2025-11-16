%% 基于WSNM的RNIPT算法
tic
clc;
clear;
close all;

% setup parameters
lambdaL =4;%4 H
C=5;%5
p=0.9;%0.9
L1=16;%L16
imgpath='..\ETPTV-HQF代码公开\data\seq1\';  
%%
imgDir = dir([imgpath '*.bmp']);
len = length(imgDir);
t1=clock;
for i=1:len
    picname=[imgpath  num2str(i),'.bmp'];
    I=imread(picname);%
    [m,n]=size(I);
    [~, ~, ch]=size(I);
    if ch==3
        I=rgb2gray(I); 
    end
    D(:,:,i)=I;
end
tenD=double(D);
[n1,n2,n3]=size(tenD);
n_1=max(n1,n2);%n(1)
n_2=min(n1,n2);%n(2)
patch_frames=L1;% temporal slide parameter
patch_num=n3/patch_frames;
for l=1:patch_num
    l
    for i=1:patch_frames
        temp(:,:,i)=tenD(:,:,patch_frames*(l-1)+i);
    end           
        T=C*sqrt(n1*n2);
        lambda4 =lambdaL / sqrt(min(n_1*patch_frames));
        mu =1e-2;%1e-2(WSNMSTIPTGS)     
        opts=[];%jia
param.Rank   = [4,4,2];% param.Rank   = [4,4,2];
    param.initial_rank = 2;%2
     param.maxIter = 50;
[tenB, tenT,change] = WSNMSTIPTETPTV_HQF(temp, lambda4, mu,T,p, param); 
 for i=1:patch_frames
     tarImg=tenT(:,:,i);
      backImg=tenB(:,:,i);
       maxv = max(max(double(I)));
   E = uint8( mat2gray(tarImg)*maxv );
   A = uint8( mat2gray(backImg)*maxv );           
 end 
t2=clock;
time_all = etime(t2,t1);
time_per_img = time_all/(len);
end
toc   