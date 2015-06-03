<html>
<head>

<title></title>
<script src="xtree.js"></script>

<link type="text/css" rel="stylesheet" href="xtree.css">


<script>
function test() {
    alert('hi');   
}
</script>

</head>
<body>


    <script>
        var tree = new WebFXTree('Root');
        tree.setBehavior('classic');
        var a = new WebFXTreeItem('1');
        a.callback(test);
        tree.add(a);
        var b = new WebFXTreeItem('1.1');
        a.add(b);
        b.add(new WebFXTreeItem('1.1.1'));
        b.add(new WebFXTreeItem('1.1.2'));
        b.add(new WebFXTreeItem('1.1.3'));
        var f = new WebFXTreeItem('1.1.4');
        b.add(f);

        document.write(tree);

        tree.toggle();
        
        
    </script>
    
</body>

</html>
