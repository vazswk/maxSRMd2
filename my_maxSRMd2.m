function my_maxSRMd2(image_path,map_path,feature_path)
% image_path = 'E:\BOSS\BOSS100Q75';QF=75;
% map_path  �޸����ļ���Ӧ��·��
% feature_path = 'E:\dct\jrm_si-qe81_50.mat';
files=dir([image_path '\*.pgm']);
file_num=length(files)
names = cell(file_num,1);
beta= cell(file_num,1);
F = zeros(file_num,34671);

for w =1:file_num
    MAPfilename = [map_path '\' files(w).name(1:end-4) '.mat'];   %% jpegfilename = 'C:\Users\VAZ\Desktop\3.jpg';
    load(MAPfilename);   %%% ע��  ���� load����������ΪOri_beta��
    beta{w} = Ori_beta;
end

parfor w =1:file_num
    tic
    jpegfilename = [image_path '\' files(w).name];   %% jpegfilename = 'C:\Users\VAZ\Desktop\3.jpg';
    I = imread(jpegfilename);
    fea = maxSRMd2(I, beta{w});
    c = struct2cell(fea);   %  �������ʽ�洢102�����͵�������ÿ�������¶�Ӧ��ͬ��ά��������
    f=[];
    for i=1:length(c)
        f = [f,c{i}];   %��102�����͵�������������������µĵ�����������;���ƣ�size(f)_= [22510,1]
    end
    F(w,:) = f;   %��f������������ʽ�洢�� w���������ĸ�������ÿ������������ͨ��F��Ӧһ�е�Ԫ�ر�ʾ %д�ɣ�����ʽ���Ϳ�����parfor
    names{w} = files(w).name;
    toc
end

save(feature_path,'F','names','-v7.3');
disp('end')