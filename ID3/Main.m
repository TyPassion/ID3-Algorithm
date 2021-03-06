%{ Team Members: Sreekanth Tangudu, Sai Krishna Chaitanya Mittapalli, Abhishek Dashinsetty}

%load iris.dat

iris = [51	35	14	2	1
49	3	14	2	1
47	32	13	2	1
46	31	15	2	1
5	36	14	2	1
54	39	17	4	1
46	34	14	3	1
5	34	15	2	1
44	29	14	2	1
49	31	15	1	1
54	37	15	2	1
48	34	16	2	1
48	3	14	1	1
43	3	11	1	1
58	4	12	2	1
57	44	15	4	1
54	39	13	4	1
51	35	14	3	1
57	38	17	3	1
51	38	15	3	1
54	34	17	2	1
51	37	15	4	1
46	36	1	2	1
51	33	17	5	1
48	34	19	2	1
5	3	16	2	1
5	34	16	4	1
52	35	15	2	1
52	34	14	2	1
47	32	16	2	1
48	31	16	2	1
54	34	15	4	1
52	41	15	1	1
55	42	14	2	1
49	31	15	2	1
5	32	12	2	1
55	35	13	2	1
49	36	14	1	1
44	3	13	2	1
51	34	15	2	1
5	35	13	3	1
45	23	13	3	1
44	32	13	2	1
5	35	16	6	1
51	38	19	4	1
48	3	14	3	1
51	38	16	2	1
46	32	14	2	1
53	37	15	2	1
5	33	14	2	1
7	32	47	14	2
64	32	45	15	2
69	31	49	15	2
55	23	4	13	2
65	28	46	15	2
57	28	45	13	2
63	33	47	16	2
49	24	33	1	2
66	29	46	13	2
52	27	39	14	2
5	2	35	1	2
59	3	42	15	2
6	22	4	1	2
61	29	47	14	2
56	29	36	13	2
67	31	44	14	2
56	3	45	15	2
58	27	41	1	2
62	22	45	15	2
56	25	39	11	2
59	32	48	18	2
61	28	4	13	2
63	25	49	15	2
61	28	47	12	2
64	29	43	13	2
66	3	44	14	2
68	28	48	14	2
67	3	5	17	2
6	29	45	15	2
57	26	35	1	2
55	24	38	11	2
55	24	37	1	2
58	27	39	12	2
6	27	51	16	2
54	3	45	15	2
6	34	45	16	2
67	31	47	15	2
63	23	44	13	2
56	3	41	13	2
55	25	4	13	2
55	26	44	12	2
61	3	46	14	2
58	26	4	12	2
5	23	33	1	2
56	27	42	13	2
57	3	42	12	2
57	29	42	13	2
62	29	43	13	2
51	25	3	11	2
57	28	41	13	2
63	33	6	25	3
58	27	51	19	3
71	3	59	21	3
63	29	56	18	3
65	3	58	22	3
76	3	66	21	3
49	25	45	17	3
73	29	63	18	3
67	25	58	18	3
72	36	61	25	3
65	32	51	2	3
64	27	53	19	3
68	3	55	21	3
57	25	5	2	3
58	28	51	24	3
64	32	53	23	3
65	3	55	18	3
77	38	67	22	3
77	26	69	23	3
6	22	5	15	3
69	32	57	23	3
56	28	49	2	3
77	28	67	2	3
63	27	49	18	3
67	33	57	21	3
72	32	6	18	3
62	28	48	18	3
61	3	49	18	3
64	28	56	21	3
72	3	58	16	3
74	28	61	19	3
79	38	64	2	3
64	28	56	22	3
63	28	51	15	3
61	26	56	14	3
77	3	61	23	3
63	34	56	24	3
64	31	55	18	3
6	3	48	18	3
69	31	54	21	3
67	31	56	24	3
69	31	51	23	3
58	27	51	19	3
68	32	59	23	3
67	33	57	25	3
67	3	52	23	3
63	25	5	19	3
65	3	52	2	3
62	34	54	23	3
59	3	51	18	3
];

nbins = 15;
accuracies = [];

for runs = 1:10
    
discretized_iris = [];

for x = 1:size(iris, 2) - 1
    
    M = iris(:, x);
    binEdges = linspace(min(M),max(M),nbins+1);    
    discretized_iris = [discretized_iris discretize(M, binEdges)]; %#ok<AGROW>
    
end

discretized_iris = [discretized_iris iris(:,5)]; %#ok<AGROW>


random_setosa_data = discretized_iris(randperm( 50), :);
other_data = discretized_iris(51:150, :);
random_other_data = other_data(randperm(100),:);


training_examples = [random_setosa_data(1:25,:);random_other_data(1:50, :)];
testing_examples = [random_setosa_data(26:50, :);random_other_data(51:100, :)];


attributes = [1 2 3 4];

tree =ID3(training_examples, 5, attributes);

accuracy = Testing(testing_examples, tree);

accuracies = [accuracies accuracy]; %#ok<AGROW>

end
accuracies
maxi=max(accuracies)
mini=min(accuracies)
avge=mean(accuracies)
x=1:10;

indexmin = find(min(accuracies) == accuracies);
xmin = x(indexmin);
ymin = accuracies(indexmin);

indexmax = find(max(accuracies) == accuracies);
xmax = x(indexmax);
ymax = accuracies(indexmax);

strmin = ['Minimum = ',num2str(min(ymin))];

strmax= ['Maximum = ',num2str(max(ymax))];

stravg=['Average',num2str(avge)];

str = sprintf('Accuracy Graph When Bins = %d', nbins);

plot(accuracies),xlabel('Observations No'),ylabel('Accuracy'),title(str)

text(xmin,ymin,strmin,'HorizontalAlignment','left')
text(xmax,ymax,strmax,'HorizontalAlignment','right')
text(2,avge,stravg,'HorizontalAlignment','center');


