﻿// using System;
using System.Windows.Input;
using System.Collections.Generic;
using VeloMax.Services;
using VeloMax.Models;
using ReactiveUI;

namespace VeloMax.ViewModels
{
    public class MainWindowViewModel : ViewModelBase
    {
        
        private bool _closeAppTrigger = false;

        private Database _db = new Database();
        // private string _searchText = "";
        private ViewModelBase _navigationContent = new();
        public ICommand DashboardButtonClicked { get; }
        public ICommand BikeButtonClicked { get; }
        public ICommand PartButtonClicked { get; }
        public ICommand ClientButtonClicked { get; }
        public ICommand OrderButtonClicked { get; }
        public ICommand OtherButtonClicked { get; }
        public ICommand StockButtonClicked { get; }
        public ICommand SupplierButtonClicked { get; }
        public ICommand CloseButtonClicked { get; }

        public ViewModelBase NavigationContent
        {
            get => this._navigationContent;
            set => this.RaiseAndSetIfChanged(ref this._navigationContent, value);
        }
        public bool CloseAppTrigger
        {
            get => this._closeAppTrigger;
            set => this.RaiseAndSetIfChanged(ref this._closeAppTrigger, value);
        }
        
        private string _searchText;
        
        // Constructor
        public MainWindowViewModel()
        {
            NavigationContent = new DashboardViewModel(_db);

            // Button
            DashboardButtonClicked = ReactiveCommand.Create(OnDashboardButtonClicked);
            BikeButtonClicked = ReactiveCommand.Create(OnBikeButtonClicked);
            PartButtonClicked = ReactiveCommand.Create(OnPartButtonClicked);
            ClientButtonClicked = ReactiveCommand.Create(OnClientButtonClicked);
            OrderButtonClicked = ReactiveCommand.Create(OnOrderButtonClicked);
            OtherButtonClicked = ReactiveCommand.Create(OnOtherButtonClicked);
            StockButtonClicked = ReactiveCommand.Create(OnStockButtonClicked);
            SupplierButtonClicked = ReactiveCommand.Create(OnSupplierButtonClicked);
            CloseButtonClicked = ReactiveCommand.Create(() => { CloseAppTrigger = true; });

        }


        private void OnDashboardButtonClicked()
        {
            this.NavigationContent = new DashboardViewModel(_db);
        }

        private void OnBikeButtonClicked()
        {
            this.NavigationContent = new BikeViewModel(_db.GetBikes(_searchText));
        }

        private void OnPartButtonClicked()
        {
            this.NavigationContent = new PartViewModel(_db.Search(_searchText), _db);
        }

        private void OnClientButtonClicked()
        {
            this.NavigationContent = new ClientViewModel(_db.GetClients());
        }

        private void OnOrderButtonClicked()
        {
            this.NavigationContent = new OrderViewModel(_db.GetOrders());
        }

        private void OnOtherButtonClicked()
        {
            this.NavigationContent = new OtherViewModel();
        }

        private void OnStockButtonClicked()
        {
            this.NavigationContent = new StockViewModel();
        }

        private void OnSupplierButtonClicked()
        {
            this.NavigationContent = new SupplierViewModel(_db.GetSuppliers());
        }

        public string SearchText
        {
            get => _searchText;
            set => this.RaiseAndSetIfChanged(ref _searchText, value);
        }
    }
}
