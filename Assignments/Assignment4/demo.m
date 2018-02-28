% [V F] = read_obj('teddy.obj');
% 
% [height ~] = size(F);
% numVertices = size(V, 1);
% 
% load LaplacianTeddyAnna.mat;
% 
% % A = sparse(numVertices, numVertices);
% % 
% % for ii=1:height
% %     v1 = F(ii, 1),v2=F(ii, 2), v3=F(ii, 3)
% %     A(v1, v3) = 1;
% %     A(v3, v1) = 1;
% %     
% %     A(v3, v2) = 1;
% %     A(v2, v3) = 1;
% %     
% %     A(v1, v2) = 1;
% %     A(v2, v1) = 1;
% % end
% 
% % full(A)
% % sum(full(A), 2)
% 
% 
% [a, d] = adjacencyDeg(F, numVertices);
% 
% L = eye(numVertices) - a\d;
% 
% % save my.mat dd
% % 
% % % csvwrite('dd.cvs', full(dd))
% % % csvwrite('d.csv', full(D_unif_Anna))
% % csvwrite('m.csv', full(M_unif_Anna))
% % csvwrite('ad.csv', full(a))
% 
% % 
% % size(a)
% % size(M_unif_Anna)
% % norm(full(dd-D_unif_Anna), 'fro')
% % norm(full(a - M_unif_Anna), 'fro')
% 
% csvwrite('area', full(inv(2*areaMat)));
% 
% 


V = [0 0 0;
     1 0 0;
     1 1 0;
     0 1 0];
 
F = [4 1 3;
     1 2 3];
 
[ar, ~] = cotArea(F,V)