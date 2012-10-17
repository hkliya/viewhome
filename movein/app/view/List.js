
Ext.define("MoveIn.view.List", {
    extend: "Ext.Carousel",
    alias: "widget.list",
    config: {
		title: "列表",
		items: [
			{
				html : 'Item 1',
				style: 'background-color: #5E99CC'
			},
			{
				html : 'Item 2',
				style: 'background-color: #759E60'
			},
			{ 
				html : 'Item 3'
			}
		]
    }
});
