
function InitTreeData() {

    $('#tree').tree({
        url: '',
        checkbox: true,
        onClick: function (node) {
            // alert(node.text);
        },
        onContextMenu: function (e, node) {
            e.preventDefault();
            $('#tree').tree('select', node.target);
        }
    });
    data: [{
        text: 'Item1',
        state: 'closed',
        children: [{
            text: 'Item11'
        }, {
            text: 'Item12'
        }]
    }, {
        text: 'Item2'
    }]
}InitTreeData();
