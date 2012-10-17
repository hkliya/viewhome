Ext.define("MoveIn.view.File", {
    extend: "Ext.Container",
    alias: "widget.file",
    config: {
		fullscreen: true,
		style: "background-color:black;",
		html: "<div style='width:100%' align='center'><img src='/view/png/page.png' /></div>",
		scrollable: {
			direction: 'both'
		}
    }
});
