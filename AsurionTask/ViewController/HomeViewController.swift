    //
    //  HomeViewController.swift
    //  AsurionTask
    //
    //  Created by Kalpesh on 27/06/20.
    //  Copyright © 2020 Kalpesh Mahajan. All rights reserved.
    //

    import UIKit
    import Alamofire
    class HomeViewController: UIViewController {
        @IBOutlet weak var tableView: UITableView!

        @IBOutlet weak var lableOfficeHours: UILabel!

        @IBOutlet weak var buttonsHolder: UIStackView!
        @IBOutlet weak var buttonChat: UIButton!
        @IBOutlet weak var buttonCall: UIButton!

        private var viewModel:HomeViewModel?




        // MARK: View LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()

            tableView.tableFooterView = UIView()


            // Do any additional setup after loading the view.

            viewModel = HomeViewModel()

            guard let viewModel = viewModel else { return }
            viewModel.reloadTableViewClosure = { [weak self] () in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            viewModel.updateSettingStatus = { [weak self] () in
                DispatchQueue.main.async {
                    self?.updateUI()
                }
            }
        }



        // MARK: UPDATE UI
        func updateUI()
        {
             guard let viewModel = viewModel else { return }
            self.lableOfficeHours.text = viewModel.settingModel?.workHours
            if viewModel.settingModel?.isChatEnabled == false && viewModel.settingModel?.isCallEnabled == false {
                self.buttonCall.isHidden = true
                self.buttonChat.isHidden = true
            }
            else if viewModel.settingModel?.isCallEnabled == false
            {
                hideCallButton()

            }
            else if viewModel.settingModel?.isChatEnabled == false
            {
                hideChatButton()
            }
        }

        func hideChatButton()
        {
            UIView.animate(withDuration: 0.1) {

                self.buttonChat.isHidden = true

            }
        }
        func hideCallButton()
        {
            UIView.animate(withDuration: 0.1) {

                self.buttonCall.isHidden = true

            }
        }


        // MARK: IBActions

        @IBAction func chatButtonClicked(_ sender: Any) {

            showAlert()


        }
        @IBAction func callButtonClicked(_ sender: Any)
        {
            showAlert()
        }

        func showAlert()
        {
             guard let viewModel = viewModel else { return }
            let message = viewModel.settingModel?.workHours.checkWorkingHours()
            
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            

        }
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.

            let vc:DetailViewController = segue.destination as! DetailViewController
            vc.selectedModel = sender as? PetModel
        }


    }
    extension HomeViewController:UITableViewDataSource,UITableViewDelegate
    {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             guard let viewModel = viewModel else { return 0 }
            return viewModel.arrPetList.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:PetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PetTableViewCell
            guard let viewModel = viewModel else { return  cell}
            cell.configureCell(model: viewModel.arrPetList[indexPath.row])
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             guard let viewModel = viewModel else { return }
            let model = viewModel.arrPetList[indexPath.row]
            self.performSegue(withIdentifier: "showDetailsVc", sender: model)
        }

    }

