Ext.define("MoveIn.controller.Notes", {
	extend: "Ext.app.Controller",
	config: {
		//http://localhost:8080/movein/app.html#login

		routes:{
			'login': 'showLoginIn',
			'home' : 'showHomeIn',
			'showform/:id' : 'showForm'
		},
		refs: {
            login: "login",
			list: "list",
			home: "home",
			form: "form9",
			newNoteBtn: "#new-note-btn",
			backHome: "#new-note-back",
			backHome2: "#new-note-back2",
			openList: "#open-list"
		},
		control: {
			newNoteBtn: {
				tap: "onNewNote"
			},
			backHome: {
				tap: "backHome"
			},
			backHome2: {
				tap: "backHome2"
			},
			openList: {
				tap: "openList"
			}
		}
	},
	preview:null,
	showLoginIn: function(){
		var login = this.getLogin();
		//Ext.Viewport.setActiveItem(home, {type: 'slide', direction: 'left'});
		if(login==null){
			login = Ext.widget("login");
		}
		Ext.Viewport.animateActiveItem(login, {type: 'slide', direction: 'right'});

	},
	showForm: function(id){
		var form = this.getForm();
		if(form==undefined){
			form = Ext.widget("form9");
		}
		Ext.Viewport.animateActiveItem(form, {type: 'slide', direction: 'left'});
	},
	showHomeIn: function(){
		var login = this.getHome();
		//Ext.Viewport.setActiveItem(home, {type: 'slide', direction: 'left'});
		if(login==null){
			login = Ext.widget("home");
		}
		Ext.Viewport.animateActiveItem(login, {type: 'slide', direction: 'right'});

	},
	backHome: function (){
		//Ext.Msg.alert('backHome.');
		var login = this.getLogin();
		//Ext.Viewport.setActiveItem(home, {type: 'slide', direction: 'left'});
		Ext.Viewport.animateActiveItem(login, {type: 'slide', direction: 'right'});
	},
	backHome2: function (){
		//Ext.Msg.alert('backHome.');
		var home = this.getHome();
		
		//Ext.Viewport.setActiveItem(home, {type: 'slide', direction: 'left'});
		Ext.Viewport.animateActiveItem(home, {type: 'slide', direction: 'right'});
	},
	onNewNote: function () {
	    //Ext.Msg.alert('Controller Event.');
		//var home = Ext.create("MoveIn.view.Home");
		//Ext.Viewport.setActiveItem(home, {type: 'slide', direction: 'left'});
		//var home = this.getHome();
		this.getApplication().redirectTo("home");
	},
	openList: function(){
		var list = this.getList();
		if(list==undefined){
			list = Ext.widget("list");
		}
		Ext.Viewport.animateActiveItem(list, {type: 'slide', direction: 'left'});
	},
	launch: function () {
		this.callParent();
		console.log("launch");
	},
	init: function () {
		this.callParent();
		console.log("init");
	}
});