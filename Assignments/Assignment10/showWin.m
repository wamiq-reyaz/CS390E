function [h, h1, h2 ] = showWin(x, y, hh, ww, xnew, ynew)
    
    % Constants
    BG_COLOR = [34 110 178]/255;
    WIN_COLOR = [239 255 25]/255;
    FIN_COLOR = [255 11 0]/255;
    
    h = figure();
    h1 = subplot(121);
    h2 = subplot(122);
    % plot1
    subplot(h1)
    patch([x, x+ww, x+ww, x]', [y, y, y+hh, y+hh]', WIN_COLOR, 'FaceAlpha', 0.6);
    set(gca, 'Color', BG_COLOR)
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    
    vline(x, 'g'); grid on; grid minor; hold on;
    
    % plot2\
    subplot(h2)
    if length(xnew) > 0 && length(ynew) == 0
        patch([xnew, xnew+ww, xnew+ww, xnew]', [y, y, y+hh, y+hh]', FIN_COLOR, 'FaceAlpha', 0.6);
        
    elseif length(xnew) == 0 && length(ynew) > 0
        patch([x, x+ww, x+ww, x]', [ynew-hh, ynew-hh, ynew, ynew]', FIN_COLOR, 'FaceAlpha', 0.6);
        
    elseif length(xnew) > 0 && length(ynew) > 0
        patch([xnew, xnew+ww, xnew+ww, xnew]', [ynew, ynew, ynew+hh, ynew+hh]', ...
                                    FIN_COLOR, 'FaceAlpha', 0.6);   
    end
    set(gca, 'Color', BG_COLOR); 
    set(gca,'xtick',[])
    set(gca,'xticklabel',[])
    
    set(gca,'ytick',[])
    set(gca,'yticklabel',[])
    grid on; grid minor; hold on;
    
    % change axis to be equal)
    eqaxsp([h1, h2], [min(x)-0.25 max(x)+2 0.75 max(y+hh)+0.25]);
    
    % Plot lines
    subplot(h1); vline(x, 'g'); hline(y, 'g'); hold off;
    if length(xnew) > 0
        subplot(h2);vline(xnew, 'r'); hold off;
    end
    if length(ynew) > 0
        subplot(h2); hline(ynew, 'r'); hold off;
    end
end


