%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
% set(0,'Units','pixels');
% scnsize = get(0,'ScreenSize');
% pos1 = [10, 10, 1910, 1070];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
file = 'SS_model.nc';

% 
ncdisp(file)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
time = ncread(file,'time')

% 
shot = ncread(file,'shot');
depth = ncread(file,'depth');
SS = ncread(file,'SS',[1 1],[Inf Inf]);
% SS = ncread(file,'temp',[1 1],[Inf Inf]);
% SS = ncread(file,'sal',[1 1],[Inf Inf]);

figure(1);
plot(shot);

figure(3);
plot(depth);

% % 
% SS_struct = struct( 'shot', shot, 'depth', depth, 'SS', SS );
% SS_mod = struct('SS',SS_struct);
% 
% [xx,yy] = meshgrid(SS_mod.SS_struct.shot,SS_mod.SS_struct.depth);
% zz = SS_mod.SS_struct.SS_struct(:,:,1);

figure(2);
% pcolor(double(xx),double(yy),double(zz))
pcolor( double(SS) );
% caxis([1500 1520]);
colorbar('location','EastOutside'); set(gca,'linewidth',1,'fontsize',16);
shading flat; axis('ij');




