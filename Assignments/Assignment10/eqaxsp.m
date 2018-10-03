function [xlim, ylim] = eqaxsp (ax, lims)
%  [xlim, ylim] = eqaxsp (ax, lims)   (equal axes subplot)
%
%  Enter a vector of plot/supblot handles (ax) and this script will find the max/min
%  of all axes and make all axes of equal length. 
%    Example = eqaxsp (h) --where h contains 2 subplot handles h(1) h(2)
%
%  Alternatively, call the function without any inputs or with an empty array for 'ax'
%    to automatically access the subplots on the active figure (see examples).  
%
%  'lim' is an optional vector to specify the x/y axis limits
%    and is arranged as follows  [xmin xmax ymin ymax]
%    Example:  exaxsp (h, [-5 20 -11 35]) 
%    Again, lims is optional.  Otherwise, this script will determine
%    The current max/min settings of all 'ax' plots.
%
%  Output:  x and y axis limits 
%   
%   Note: to get all subplot axes handles:  findall(gcf,'type','axes')
%
%   Example:
%             figure
%             sp(1) = subplot(2,2,1);
%              x = (1:10);
%              plot(x, rand(1,10)*1.3);
%             sp(2) = subplot(2,2,2);
%              x = (4:13);
%              plot(x, rand(1,10)*3);
%             sp(3) = subplot(2,2,3);
%              x = (3:12);
%              plot(x, rand(1,10)*4.5);
%             sp(4) = subplot(2,2,4);
%              x = (5:14);
%              plot(x, rand(1,10)*6);
% 
%              eqaxsp                         %Automatic detection of current subplots (a bit risky).  
%              eqaxsp(sp)                     %Automatic axes method
%              eqaxsp(sp, [-1 18 0 10]);      %Set axes method
%              eqaxsp([], [-1 18 0 10]);      &if you don't have handles but want to set axes lims
%              
%  
%  140312  Danz  
% adam%danz@gmail.com


if nargin < 1 || isempty(ax)
    % use 'findall' to get a list of current axes.  This could lead to error - better to use handles
    ax = findall(gcf,'type','axes');
end

if nargin < 2 || isempty(lims)              %if lims is not specified
    %get xlim/ylim for all plots
    try
        allxl = cell2mat(get(ax, 'xlim'));
        allyl = cell2mat(get(ax, 'ylim'));
    catch
        allxl = get(ax, 'xlim');
        allyl = get(ax, 'ylim');
    end

    %get max / min of each x, y
    mxy = max(allyl(:,2));
    mny = min(allyl(:,1));

    mxx = max(allxl(:,2));
    mnx = min(allxl(:,1));

    xlim = [mnx mxx];
    ylim = [mny mxy];

% in the future it would be nice to specifiy only one of the axes (x|y).  This next line does that.  But it would have to go before the first if section.     
% elseif sum(lims(1:2)==0)==2 | sum(lims(3:4)==0)==2  %if lims is specified and 1 pair is marked (0,0)
else
        
    xlim = lims(1:2);
    ylim = lims(3:4);
end


%set all axes lims
for i = 1:length(ax)          %for each plot / subplot
    h = ax(i);                %current subplot axis (or plot axis)
    set(h, 'XLim', xlim)
    set(h, 'YLim', ylim)
end


