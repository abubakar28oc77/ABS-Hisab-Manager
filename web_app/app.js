/**
 * ABS Hisab Manager - Complete Interactive Web Application
 * Logic & Local Database Controller
 */

// ==================== I18N DICTIONARY ====================
const translations = {
  bn: {
    app_name: 'ABS হিসাব ম্যানেজার',
    dashboard: 'ড্যাশবোর্ড',
    students: 'শিক্ষার্থী',
    transactions: 'লেনদেন',
    settings: 'সেটিংস',
    good_morning: 'শুভ সকাল',
    good_afternoon: 'শুভ দুপুর',
    good_evening: 'শুভ সন্ধ্যা',
    net_balance: 'নিট ব্যালেন্স',
    income: 'আয়',
    expense: 'ব্যয়',
    total_income_month: 'মোট আয় (এই মাসে)',
    total_expense_month: 'মোট ব্যয় (এই মাসে)',
    pending_fees: 'বাকি ফি',
    quick_actions: 'কুইক অ্যাকশন',
    quick_collect_fee: 'ফি গ্রহণ',
    quick_add_student: 'শিক্ষার্থী যোগ',
    quick_add_expense: 'ব্যয় যোগ',
    quick_reports: 'রিপোর্টস',
    recent_transactions: 'সাম্প্রতিক লেনদেন',
    see_all: 'সব দেখুন',
    expense_breakdown: 'ব্যয়ের বিবরণী',
    search_students: 'নাম, রোল, পিতার মোবাইল দিয়ে খুঁজুন...',
    all: 'সব',
    filter_all: 'সকল শ্রেণি',
    filter_due: 'বকেয়া আছে',
    filter_paid: 'পরিশোধিত',
    filter_advance: 'অগ্রিম',
    add_student: 'শিক্ষার্থী যুক্ত করুন',
    edit_student: 'শিক্ষার্থী সম্পাদনা',
    student_profile: 'শিক্ষার্থীর প্রোফাইল',
    monthly_fee: 'মাসিক ফি',
    address: 'ঠিকানা',
    admission_date: 'ভর্তির তারিখ',
    fathers_name: 'পিতার নাম',
    fathers_mobile: 'পিতার মোবাইল',
    notes: 'নোট',
    call_father: 'পিতার সাথে কল',
    message: 'মেসেজ',
    send_due_sms: 'বকেয়া রিমাইন্ডার SMS',
    total_expected: 'মোট প্রত্যাশিত',
    total_paid: 'মোট পরিশোধিত',
    due: 'বাকি',
    advance: 'অগ্রিম',
    payment_history: 'পেমেন্ট ইতিহাস',
    no_payments_yet: 'কোনো পেমেন্ট রেকর্ড নেই',
    class_attendance: 'ক্লাস উপস্থিতি',
    classes: 'ক্লাস',
    collect_payment: 'পেমেন্ট সংগ্রহ',
    current_due: 'বর্তমান বাকি',
    amount: 'টাকার পরিমাণ',
    payment_method: 'পেমেন্ট মাধ্যম',
    payment_date: 'পেমেন্টের তারিখ',
    month_hint: 'প্রযোজ্য মাস',
    receipt_now_desc: 'এখনই মানি রিসিট (Receipt) তৈরি করবেন?',
    save_payment: 'পেমেন্ট সেভ করুন ও রশিদ তৈরি করুন',
    delete_confirm: 'আপনি কি নিশ্চিত এটি ডিলিট করতে চান?',
    no_phone_msg: 'পিতার মোবাইল নম্বর দেওয়া হয়নি!',
    no_due_msg: 'শিক্ষার্থীর কোনো বকেয়া ফি নেই!',
    receipt_given: 'রশিদ দেওয়া হয়েছে',
    no_receipt: 'রশিদ নেই',
    statement_pdf: 'স্টেটমেন্ট PDF',
    vs_last_month: 'গত মাসের তুলনায়',
    language: 'ভাষা (Language)',
    security: 'নিরাপত্তা (Security)',
    finance: 'আর্থিক হিসাব (Finance)',
    data_backup: 'ডাটা ও ব্যাকআপ',
    about: 'সম্পর্কে',
  },
  en: {
    app_name: 'ABS Hisab Manager',
    dashboard: 'Dashboard',
    students: 'Students',
    transactions: 'Transactions',
    settings: 'Settings',
    good_morning: 'Good morning',
    good_afternoon: 'Good afternoon',
    good_evening: 'Good evening',
    net_balance: 'Net Balance',
    income: 'Income',
    expense: 'Expense',
    total_income_month: 'Total Income (This Month)',
    total_expense_month: 'Total Expense (This Month)',
    pending_fees: 'Pending Fees',
    quick_actions: 'Quick Actions',
    quick_collect_fee: 'Collect Fee',
    quick_add_student: 'Add Student',
    quick_add_expense: 'Add Expense',
    quick_reports: 'Reports',
    recent_transactions: 'Recent Transactions',
    see_all: 'See all',
    expense_breakdown: 'Expense Breakdown',
    search_students: 'Search by name, roll, mobile...',
    all: 'All',
    filter_all: 'All Classes',
    filter_due: 'With Due',
    filter_paid: 'Paid',
    filter_advance: 'Advance',
    add_student: 'Add Student',
    edit_student: 'Edit Student',
    student_profile: 'Student Profile',
    monthly_fee: 'Monthly Fee',
    address: 'Address',
    admission_date: 'Admission Date',
    fathers_name: "Father's Name",
    fathers_mobile: "Father's Mobile",
    notes: 'Notes',
    call_father: 'Call Father',
    message: 'Message',
    send_due_sms: 'Send Due Reminder SMS',
    total_expected: 'Total Expected',
    total_paid: 'Total Paid',
    due: 'Due',
    advance: 'Advance',
    payment_history: 'Payment History',
    no_payments_yet: 'No payment records yet',
    class_attendance: 'Class Attendance',
    classes: 'classes',
    collect_payment: 'Collect Payment',
    current_due: 'Current Due',
    amount: 'Amount',
    payment_method: 'Payment Method',
    payment_date: 'Payment Date',
    month_hint: 'For Month',
    receipt_now_desc: 'Generate Money Receipt now?',
    save_payment: 'Save Payment & Generate Receipt',
    delete_confirm: 'Are you sure you want to delete this?',
    no_phone_msg: 'Father mobile number is empty!',
    no_due_msg: 'Student has no pending due!',
    receipt_given: 'Receipt given',
    no_receipt: 'No receipt',
    statement_pdf: 'Statement PDF',
    vs_last_month: 'vs last month',
    language: 'Language',
    security: 'Security',
    finance: 'Finance',
    data_backup: 'Data & Backup',
    about: 'About',
  }
};

// ==================== DEFAULT INITIAL SAMPLE DATA ====================
const defaultCategories = {
  income: ['Tuition', 'Salary', 'Bonus', 'Other Income'],
  expense: ['Food', 'Travel', 'Books', 'Bills', 'Rent', 'Shopping', 'Other']
};

const defaultStudents = [
  {
    id: 'std-1',
    name: 'রাফসান আহমেদ (Rafsan)',
    className: 'Nine',
    rollNumber: '05',
    section: 'A',
    monthlyFee: 2500,
    fatherName: 'মাহবুব আলম',
    fatherPhone: '01711223344',
    address: 'মিরপুর-১০, ঢাকা',
    admissionDate: '2025-01-01',
    notes: 'পদার্থ ও উচ্চতর গণিত',
    attendance: { '2026-09': 14, '2026-08': 16 }
  },
  {
    id: 'std-2',
    name: 'সাদিয়া ইসলাম (Sadia)',
    className: 'Ten',
    rollNumber: '02',
    section: 'B',
    monthlyFee: 3000,
    fatherName: 'রফিকুল ইসলাম',
    fatherPhone: '01822334455',
    address: 'উত্তরা সেক্টর ৭, ঢাকা',
    admissionDate: '2025-02-01',
    notes: 'ইংরেজি ও আইসিটি',
    attendance: { '2026-09': 12, '2026-08': 15 }
  },
  {
    id: 'std-3',
    name: 'তানভীর হাসান (Tanvir)',
    className: 'Eight',
    rollNumber: '11',
    section: 'A',
    monthlyFee: 2000,
    fatherName: 'মোশাররফ হোসেন',
    fatherPhone: '01933445566',
    address: 'ধানমন্ডি, ঢাকা',
    admissionDate: '2025-03-01',
    notes: 'সাধারণ গণিত',
    attendance: { '2026-09': 10, '2026-08': 14 }
  }
];

const defaultPayments = [
  {
    id: 'pay-1',
    studentId: 'std-1',
    amount: 2500,
    method: 'bKash',
    paymentDate: '2026-08-05',
    forMonth: '2026-08',
    receiptNo: 'RCT-202608-0001',
    receiptGiven: true,
    note: 'আগস্ট মাসের ফি'
  },
  {
    id: 'pay-2',
    studentId: 'std-2',
    amount: 3000,
    method: 'Cash',
    paymentDate: '2026-08-10',
    forMonth: '2026-08',
    receiptNo: 'RCT-202608-0002',
    receiptGiven: true,
    note: 'ক্যাশ পরিশোধ'
  },
  {
    id: 'pay-3',
    studentId: 'std-1',
    amount: 2500,
    method: 'bKash',
    paymentDate: '2026-09-02',
    forMonth: '2026-09',
    receiptNo: 'RCT-202609-0001',
    receiptGiven: true,
    note: 'সেপ্টেম্বর মাসের ফি'
  }
];

const defaultTransactions = [
  {
    id: 'pay-1',
    amount: 2500,
    type: 'income',
    category: 'Tuition',
    date: '2026-08-05',
    note: 'Tuition fee - রাফসান আহমেদ (Rafsan) (RCT-202608-0001)',
    linkedStudentId: 'std-1'
  },
  {
    id: 'pay-2',
    amount: 3000,
    type: 'income',
    category: 'Tuition',
    date: '2026-08-10',
    note: 'Tuition fee - সাদিয়া ইসলাম (Sadia) (RCT-202608-0002)',
    linkedStudentId: 'std-2'
  },
  {
    id: 'pay-3',
    amount: 2500,
    type: 'income',
    category: 'Tuition',
    date: '2026-09-02',
    note: 'Tuition fee - রাফসান আহমেদ (Rafsan) (RCT-202609-0001)',
    linkedStudentId: 'std-1'
  },
  {
    id: 'txn-1',
    amount: 650,
    type: 'expense',
    category: 'Books',
    date: '2026-09-01',
    note: 'গাইড ও টেস্ট পেপার ক্রয়'
  },
  {
    id: 'txn-2',
    amount: 400,
    type: 'expense',
    category: 'Travel',
    date: '2026-09-02',
    note: 'সিএনজি ও রিকশা ভাড়া'
  },
  {
    id: 'txn-3',
    amount: 1200,
    type: 'expense',
    category: 'Bills',
    date: '2026-08-25',
    note: 'ইন্টারনেট বিল'
  }
];

// ==================== STATE ENGINE ====================
class AppState {
  constructor() {
    this.init();
  }

  init() {
    this.students = JSON.parse(localStorage.getItem('abs_students')) || defaultStudents;
    this.payments = JSON.parse(localStorage.getItem('abs_payments')) || defaultPayments;
    this.transactions = JSON.parse(localStorage.getItem('abs_transactions')) || defaultTransactions;
    this.categories = JSON.parse(localStorage.getItem('abs_categories')) || defaultCategories;
    this.settings = JSON.parse(localStorage.getItem('abs_settings')) || {
      lang: 'bn',
      pin: '',
      biometric: false,
    };
    this.currentView = 'dashboard';
    this.selectedStudentId = null;
    this.studentStatusFilter = 'all';
    this.studentClassFilter = 'All';
    this.txnTypeFilter = 'all';
    this.enteredPin = '';
    this.currentReportPeriod = 'monthly';
    this.reportAnchorDate = new Date();
  }

  save() {
    localStorage.setItem('abs_students', JSON.stringify(this.students));
    localStorage.setItem('abs_payments', JSON.stringify(this.payments));
    localStorage.setItem('abs_transactions', JSON.stringify(this.transactions));
    localStorage.setItem('abs_categories', JSON.stringify(this.categories));
    localStorage.setItem('abs_settings', JSON.stringify(this.settings));
  }

  t(key) {
    const lang = this.settings.lang || 'bn';
    return (translations[lang] && translations[lang][key]) || translations['en'][key] || key;
  }

  // Calculation Helpers
  getMonthsSince(admissionDateStr) {
    const adm = new Date(admissionDateStr);
    const now = new Date();
    let months = (now.getFullYear() - adm.getFullYear()) * 12 + (now.getMonth() - adm.getMonth());
    if (now.getDate() < adm.getDate()) months -= 1;
    return months < 0 ? 0 : months;
  }

  getTotalExpected(student) {
    return this.getMonthsSince(student.admissionDate) * student.monthlyFee;
  }

  getTotalPaid(studentId) {
    return this.payments
      .filter(p => p.studentId === studentId)
      .reduce((sum, p) => sum + Number(p.amount), 0);
  }

  getStudentDue(student) {
    const expected = this.getTotalExpected(student);
    const paid = this.getTotalPaid(student.id);
    const diff = expected - paid;
    return diff > 0 ? diff : 0;
  }

  getStudentAdvance(student) {
    const expected = this.getTotalExpected(student);
    const paid = this.getTotalPaid(student.id);
    const diff = paid - expected;
    return diff > 0 ? diff : 0;
  }

  getNextReceiptNo() {
    const now = new Date();
    const prefix = `RCT-${now.getFullYear()}${String(now.getMonth() + 1).padStart(2, '0')}-`;
    const count = this.payments.filter(p => p.receiptNo && p.receiptNo.startsWith(prefix)).length;
    return `${prefix}${String(count + 1).padStart(4, '0')}`;
  }

  // Monthly Financial Summaries
  getMonthIncome(month, year) {
    return this.transactions
      .filter(t => {
        const d = new Date(t.date);
        return t.type === 'income' && d.getMonth() === month && d.getFullYear() === year;
      })
      .reduce((sum, t) => sum + Number(t.amount), 0);
  }

  getMonthExpense(month, year) {
    return this.transactions
      .filter(t => {
        const d = new Date(t.date);
        return t.type === 'expense' && d.getMonth() === month && d.getFullYear() === year;
      })
      .reduce((sum, t) => sum + Number(t.amount), 0);
  }

  getPendingFeesTotal() {
    return this.students.reduce((sum, s) => sum + this.getStudentDue(s), 0);
  }

  getExpenseCategoryBreakdown() {
    const map = {};
    this.transactions
      .filter(t => t.type === 'expense')
      .forEach(t => {
        map[t.category] = (map[t.category] || 0) + Number(t.amount);
      });
    return map;
  }
}

const state = new AppState();

// ==================== INITIALIZATION ====================
document.addEventListener('DOMContentLoaded', () => {
  applyLanguage();
  checkPinLock();
  renderDashboard();
  renderStudentsList();
  renderTransactionsList();
  renderCategoriesList();
  
  // Set default dates on forms
  const today = new Date().toISOString().split('T')[0];
  const curMonth = today.substring(0, 7);
  if (document.getElementById('fmAdmissionDate')) document.getElementById('fmAdmissionDate').value = today;
  if (document.getElementById('pmDate')) document.getElementById('pmDate').value = today;
  if (document.getElementById('pmMonth')) document.getElementById('pmMonth').value = curMonth;
  if (document.getElementById('txnDate')) document.getElementById('txnDate').value = today;
});

// ==================== LANGUAGE & LOCALIZATION ====================
function setLanguage(lang) {
  state.settings.lang = lang;
  state.save();
  applyLanguage();
  renderDashboard();
  renderStudentsList();
  renderTransactionsList();
  if (state.selectedStudentId) renderStudentDetail(state.selectedStudentId);
}

function applyLanguage() {
  const isBn = state.settings.lang === 'bn';
  document.getElementById('currentLangLabel').innerText = isBn ? 'EN' : 'বাং';
  document.getElementById('langBtnEn').classList.toggle('active', !isBn);
  document.getElementById('langBtnBn').classList.toggle('active', isBn);

  // Time based greeting
  const hour = new Date().getHours();
  const greetingKey = hour < 12 ? 'good_morning' : hour < 17 ? 'good_afternoon' : 'good_evening';
  document.getElementById('greetingText').innerText = state.t(greetingKey);
  document.getElementById('appTitle').innerText = state.t('app_name');

  // Dashboard translations
  document.getElementById('netBalanceLabel').innerText = state.t('net_balance');
  document.getElementById('quickActionsTitle').innerText = state.t('quick_actions');
  document.getElementById('qaCollectLabel').innerText = state.t('quick_collect_fee');
  document.getElementById('qaStudentLabel').innerText = state.t('quick_add_student');
  document.getElementById('qaExpenseLabel').innerText = state.t('quick_add_expense');
  document.getElementById('qaReportLabel').innerText = state.t('quick_reports');
  document.getElementById('lblIncomeMonth').innerText = state.t('total_income_month');
  document.getElementById('lblExpenseMonth').innerText = state.t('total_expense_month');
  document.getElementById('lblPendingFees').innerText = state.t('pending_fees');
  document.getElementById('lblTotalStudents').innerText = state.t('students');
  document.getElementById('lblExpenseBreakdown').innerText = state.t('expense_breakdown');
  document.getElementById('lblRecentTransactions').innerText = state.t('recent_transactions');
  document.getElementById('btnSeeAllTxn').innerText = state.t('see_all');

  // Navigation labels
  document.getElementById('navLblDashboard').innerText = state.t('dashboard');
  document.getElementById('navLblStudents').innerText = state.t('students');
  document.getElementById('navLblTransactions').innerText = state.t('transactions');
  document.getElementById('navLblSettings').innerText = state.t('settings');

  // Student list search placeholder
  document.getElementById('studentSearchInput').placeholder = state.t('search_students');
}

// Language toggle header button
document.getElementById('langToggleBtn').addEventListener('click', () => {
  const nextLang = state.settings.lang === 'bn' ? 'en' : 'bn';
  setLanguage(nextLang);
});

// ==================== NAVIGATION TABS ====================
function switchNavTab(tabName) {
  state.currentView = tabName;
  document.querySelectorAll('.tab-content .view').forEach(el => el.classList.remove('active'));
  document.querySelectorAll('.bottom-nav .nav-item').forEach(el => el.classList.remove('active'));

  const viewEl = document.getElementById(`${tabName}View`);
  const navBtn = document.querySelector(`.bottom-nav .nav-item[data-tab="${tabName}"]`);
  if (viewEl) viewEl.classList.add('active');
  if (navBtn) navBtn.classList.add('active');

  // Update FAB visibility / action
  const fab = document.getElementById('fabBtn');
  if (tabName === 'dashboard' || tabName === 'transactions') {
    fab.style.display = 'flex';
    fab.innerHTML = '<i class="fa-solid fa-plus"></i>';
  } else if (tabName === 'students') {
    fab.style.display = 'flex';
    fab.innerHTML = '<i class="fa-solid fa-user-plus"></i>';
  } else {
    fab.style.display = 'none';
  }

  // Refresh view data
  if (tabName === 'dashboard') renderDashboard();
  if (tabName === 'students') renderStudentsList();
  if (tabName === 'transactions') renderTransactionsList();
}

function onFabClicked() {
  if (state.currentView === 'students') {
    openAddStudentModal();
  } else {
    openAddTransactionModal('expense');
  }
}

// ==================== DASHBOARD RENDERING ====================
function renderDashboard() {
  const now = new Date();
  const curMonth = now.getMonth();
  const curYear = now.getFullYear();

  const thisMonthIncome = state.getMonthIncome(curMonth, curYear);
  const thisMonthExpense = state.getMonthExpense(curMonth, curYear);
  const thisMonthNet = thisMonthIncome - thisMonthExpense;

  const lastMonthDate = new Date(curYear, curMonth - 1, 1);
  const lastMonthIncome = state.getMonthIncome(lastMonthDate.getMonth(), lastMonthDate.getFullYear());
  const lastMonthExpense = state.getMonthExpense(lastMonthDate.getMonth(), lastMonthDate.getFullYear());
  const lastMonthNet = lastMonthIncome - lastMonthExpense;
  const netDelta = thisMonthNet - lastMonthNet;

  document.getElementById('netBalanceAmount').innerText = `৳ ${thisMonthNet.toLocaleString('en-IN', { minimumFractionDigits: 2 })}`;
  
  const isUp = netDelta >= 0;
  const deltaBadge = document.getElementById('balanceDelta');
  deltaBadge.style.color = isUp ? '#a7f3d0' : '#fca5a5';
  deltaBadge.innerHTML = `
    <i class="fa-solid ${isUp ? 'fa-arrow-trend-up' : 'fa-arrow-trend-down'}"></i>
    <span>${isUp ? '+' : ''}৳ ${netDelta.toLocaleString('en-IN', { minimumFractionDigits: 2 })} ${state.t('vs_last_month')}</span>
  `;

  document.getElementById('valIncomeMonth').innerText = `৳ ${thisMonthIncome.toLocaleString('en-IN')}`;
  document.getElementById('valExpenseMonth').innerText = `৳ ${thisMonthExpense.toLocaleString('en-IN')}`;
  document.getElementById('valPendingFees').innerText = `৳ ${state.getPendingFeesTotal().toLocaleString('en-IN')}`;
  document.getElementById('valTotalStudents').innerText = `${state.students.length}`;

  // Draw Pie Chart
  drawExpensePieChart();

  // Render Recent Transactions (Last 5)
  const recentList = document.getElementById('recentTxnList');
  const sorted = [...state.transactions].sort((a, b) => new Date(b.date) - new Date(a.date)).slice(0, 5);
  
  if (sorted.length === 0) {
    recentList.innerHTML = `<div style="text-align:center; padding:18px; color:var(--text-muted); font-size:13px;">কোনো লেনদেন নেই</div>`;
  } else {
    recentList.innerHTML = sorted.map(t => renderTxnCardHtml(t)).join('');
  }
}

function drawExpensePieChart() {
  const canvas = document.getElementById('expensePieChart');
  if (!canvas) return;
  const ctx = canvas.getContext('2d');
  const breakdown = state.getExpenseCategoryBreakdown();
  const entries = Object.entries(breakdown);
  const total = entries.reduce((s, [, v]) => s + v, 0);
  const legend = document.getElementById('expenseChartLegend');

  ctx.clearRect(0, 0, canvas.width, canvas.height);

  if (total === 0 || entries.length === 0) {
    ctx.beginPath();
    ctx.arc(60, 60, 48, 0, 2 * Math.PI);
    ctx.strokeStyle = '#e2e8f0';
    ctx.lineWidth = 14;
    ctx.stroke();
    legend.innerHTML = `<div style="font-size:12px; color:var(--text-muted);">এখনো কোনো ব্যয় নেই</div>`;
    return;
  }

  const colors = ['#4f46e5', '#06b6d4', '#f59e0b', '#ef4444', '#8b5cf6', '#10b981', '#f97316', '#64748b'];
  let startAngle = -Math.PI / 2;

  entries.forEach(([cat, amt], i) => {
    const sliceAngle = (amt / total) * 2 * Math.PI;
    ctx.beginPath();
    ctx.arc(60, 60, 46, startAngle, startAngle + sliceAngle);
    ctx.strokeStyle = colors[i % colors.length];
    ctx.lineWidth = 18;
    ctx.stroke();
    startAngle += sliceAngle;
  });

  // Render Legend
  legend.innerHTML = entries.map(([cat, amt], i) => {
    const pct = Math.round((amt / total) * 100);
    const color = colors[i % colors.length];
    return `
      <div class="legend-item">
        <div class="legend-left">
          <div class="legend-dot" style="background:${color}"></div>
          <span>${cat}</span>
        </div>
        <span class="legend-pct">${pct}%</span>
      </div>
    `;
  }).join('');
}

function renderTxnCardHtml(t) {
  const isIncome = t.type === 'income';
  const icon = isIncome ? 'fa-arrow-down-left' : 'fa-arrow-up-right';
  return `
    <div class="txn-item-card ${isIncome ? 'txn-income' : 'txn-expense'}">
      <div class="txn-left">
        <div class="txn-icon"><i class="fa-solid ${icon}"></i></div>
        <div>
          <div class="txn-category">${t.category}</div>
          <div class="txn-date">${t.date} ${t.note ? '· ' + t.note : ''}</div>
        </div>
      </div>
      <div style="display:flex; align-items:center;">
        <span class="txn-amount">${isIncome ? '+' : '-'}৳ ${Number(t.amount).toLocaleString('en-IN')}</span>
        <button class="txn-delete-btn" onclick="deleteTransaction('${t.id}')" title="Delete"><i class="fa-solid fa-trash-can"></i></button>
      </div>
    </div>
  `;
}

// ==================== STUDENTS VIEW & FILTERS ====================
function setStudentStatusFilter(status) {
  state.studentStatusFilter = status;
  document.querySelectorAll('#studentStatusChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-status') === status);
  });
  renderStudentsList();
}

function setStudentClassFilter(className) {
  state.studentClassFilter = className;
  document.querySelectorAll('#studentClassChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-class') === className);
  });
  renderStudentsList();
}

function clearStudentSearch() {
  document.getElementById('studentSearchInput').value = '';
  renderStudentsList();
}

function renderStudentsList() {
  const listEl = document.getElementById('studentsList');
  if (!listEl) return;
  const query = (document.getElementById('studentSearchInput')?.value || '').trim().toLowerCase();

  const filtered = state.students.filter(s => {
    // 1. Query Filter
    if (query) {
      const matchName = s.name.toLowerCase().includes(query);
      const matchRoll = (s.rollNumber || '').toLowerCase().includes(query);
      const matchFather = (s.fatherName || '').toLowerCase().includes(query);
      const matchPhone = (s.fatherPhone || '').toLowerCase().includes(query);
      if (!matchName && !matchRoll && !matchFather && !matchPhone) return false;
    }
    // 2. Class Filter
    if (state.studentClassFilter !== 'All' && s.className !== state.studentClassFilter) {
      return false;
    }
    // 3. Status Filter
    const due = state.getStudentDue(s);
    const advance = state.getStudentAdvance(s);
    if (state.studentStatusFilter === 'due' && due <= 0) return false;
    if (state.studentStatusFilter === 'paid' && (due > 0 || advance > 0)) return false;
    if (state.studentStatusFilter === 'advance' && advance <= 0) return false;

    return true;
  });

  if (filtered.length === 0) {
    listEl.innerHTML = `
      <div style="text-align:center; padding:36px 20px; color:var(--text-muted);">
        <i class="fa-solid fa-user-slash" style="font-size:36px; opacity:0.3; margin-bottom:10px;"></i>
        <p style="font-size:14px; font-weight:600;">কোনো শিক্ষার্থী পাওয়া যায়নি</p>
      </div>
    `;
    return;
  }

  listEl.innerHTML = filtered.map(s => {
    const due = state.getStudentDue(s);
    const advance = state.getStudentAdvance(s);
    const initial = s.name ? s.name.trim().charAt(0).toUpperCase() : '?';

    let badgeHtml = '';
    if (due > 0) {
      badgeHtml = `<span class="badge-pill badge-due">বাকি: ৳ ${due.toLocaleString('en-IN')}</span>`;
    } else if (advance > 0) {
      badgeHtml = `<span class="badge-pill badge-advance">অগ্রিম: ৳ ${advance.toLocaleString('en-IN')}</span>`;
    } else {
      badgeHtml = `<span class="badge-pill badge-paid">পরিশোধিত</span>`;
    }

    return `
      <div class="student-item-card" onclick="openStudentDetailModal('${s.id}')">
        <div class="student-avatar">${initial}</div>
        <div class="student-main-info">
          <div class="student-name">${s.name}</div>
          <div class="student-meta">${s.className} · Roll ${s.rollNumber} · Sec ${s.section || '—'}</div>
        </div>
        <div class="student-right-info">
          <div class="student-fee">৳ ${Number(s.monthlyFee).toLocaleString('en-IN')}</div>
          ${badgeHtml}
        </div>
      </div>
    `;
  }).join('');
}

// ==================== STUDENT DETAIL & PROFILE ====================
function openStudentDetailModal(studentId) {
  state.selectedStudentId = studentId;
  renderStudentDetail(studentId);
  openModal('studentDetailModal');
}

function renderStudentDetail(studentId) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  document.getElementById('studentDetailName').innerText = student.name;
  const due = state.getStudentDue(student);
  const advance = state.getStudentAdvance(student);
  const expected = state.getTotalExpected(student);
  const paid = state.getTotalPaid(student.id);
  const payments = state.payments.filter(p => p.studentId === student.id).sort((a, b) => new Date(b.paymentDate) - new Date(a.paymentDate));

  const curMonthKey = new Date().toISOString().substring(0, 7);
  const classesThisMonth = student.attendance ? (student.attendance[curMonthKey] || 0) : 0;

  const body = document.getElementById('studentDetailBody');
  body.innerHTML = `
    <!-- Top Info Box -->
    <div style="background:var(--background); padding:16px; border-radius:var(--radius-md); border:1px solid var(--border);">
      <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
        <span style="color:var(--text-muted); font-size:13px;">শ্রেণি ও রোল:</span>
        <strong style="font-size:13px;">${student.className} · Roll ${student.rollNumber} (${student.section || '—'})</strong>
      </div>
      <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
        <span style="color:var(--text-muted); font-size:13px;">মাসিক ফি:</span>
        <strong style="font-size:14px; color:var(--primary);">৳ ${Number(student.monthlyFee).toLocaleString('en-IN')}</strong>
      </div>
      <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
        <span style="color:var(--text-muted); font-size:13px;">পিতার নাম ও মোবাইল:</span>
        <span style="font-size:13px; font-weight:600;">${student.fatherName || '—'} (${student.fatherPhone || '—'})</span>
      </div>
      <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
        <span style="color:var(--text-muted); font-size:13px;">ভর্তির তারিখ:</span>
        <span style="font-size:13px;">${student.admissionDate || '—'}</span>
      </div>
      ${student.address ? `
      <div style="display:flex; justify-content:space-between;">
        <span style="color:var(--text-muted); font-size:13px;">ঠিকানা:</span>
        <span style="font-size:13px;">${student.address}</span>
      </div>` : ''}

      <!-- Contact Actions -->
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:10px; margin-top:14px;">
        <button class="pill-btn" style="background:white; border:1px solid var(--border); padding:8px; display:flex; align-items:center; justify-content:center; gap:6px;" onclick="callFatherPhone('${student.fatherPhone}')">
          <i class="fa-solid fa-phone" style="color:var(--primary)"></i> কল দিন
        </button>
        <button class="pill-btn" style="background:white; border:1px solid var(--border); padding:8px; display:flex; align-items:center; justify-content:center; gap:6px;" onclick="messageFatherPhone('${student.fatherPhone}')">
          <i class="fa-solid fa-comment-sms" style="color:var(--secondary)"></i> মেসেজ
        </button>
      </div>

      <!-- One-Tap Due Reminder SMS Button -->
      ${due > 0 ? `
      <button class="submit-btn btn-expense" style="margin-top:10px; padding:10px; font-size:13px; display:flex; align-items:center; justify-content:center; gap:8px;" onclick="sendDueReminderSms('${student.id}')">
        <i class="fa-solid fa-paper-plane"></i> ${state.t('send_due_sms')} (৳ ${due.toLocaleString('en-IN')})
      </button>` : ''}
    </div>

    <!-- 4 Stats Grid -->
    <div class="stats-grid" style="margin-top:14px;">
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট প্রত্যাশিত</div>
          <div class="stat-value">৳ ${expected.toLocaleString('en-IN')}</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট পরিশোধিত</div>
          <div class="stat-value" style="color:var(--income)">৳ ${paid.toLocaleString('en-IN')}</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">বর্তমান বাকি</div>
          <div class="stat-value" style="color:var(--expense)">৳ ${due.toLocaleString('en-IN')}</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">অগ্রিম ব্যালেন্স</div>
          <div class="stat-value" style="color:var(--secondary)">৳ ${advance.toLocaleString('en-IN')}</div>
        </div>
      </div>
    </div>

    <!-- Attendance Box -->
    <div class="card-box mt-3">
      <div style="display:flex; justify-content:space-between; align-items:center;">
        <div>
          <div style="font-size:12px; color:var(--text-muted);">চলতি মাসের ক্লাস উপস্থিতি (${curMonthKey})</div>
          <div style="font-size:20px; font-weight:800; color:var(--text-main); margin-top:2px;">${classesThisMonth} টি ক্লাস</div>
        </div>
        <div style="display:flex; gap:8px;">
          <button class="icon-action-btn" onclick="updateStudentAttendance('${student.id}', -1)"><i class="fa-solid fa-minus"></i></button>
          <button class="icon-action-btn" style="background:var(--primary); color:white; border-color:var(--primary);" onclick="updateStudentAttendance('${student.id}', 1)"><i class="fa-solid fa-plus"></i></button>
        </div>
      </div>
    </div>

    <!-- Payment History -->
    <div class="box-header-row mt-4">
      <div class="box-title">পেমেন্ট ইতিহাস (${payments.length})</div>
      <button class="pill-btn btn-income" style="background:var(--income); color:white; padding:6px 12px; font-size:12px;" onclick="openCollectPaymentForStudent('${student.id}')">
        <i class="fa-solid fa-plus"></i> ফি সংগ্রহ
      </button>
    </div>

    <div class="payment-history-list mt-2">
      ${payments.length === 0 ? '<div style="color:var(--text-muted); font-size:13px; text-align:center; padding:14px;">কোনো পেমেন্ট রেকর্ড নেই</div>' : payments.map(p => `
        <div style="background:white; border:1px solid var(--border); padding:12px; border-radius:var(--radius-md); margin-bottom:8px; display:flex; justify-content:space-between; align-items:center;">
          <div>
            <div style="font-weight:700; font-size:15px; color:var(--income);">৳ ${Number(p.amount).toLocaleString('en-IN')}</div>
            <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">${p.receiptNo} · ${p.paymentDate} · ${p.method} (${p.forMonth})</div>
            ${p.note ? `<div style="font-size:11px; color:var(--text-main); margin-top:1px;">নোট: ${p.note}</div>` : ''}
          </div>
          <div style="display:flex; gap:6px;">
            <button class="icon-action-btn" title="Print Receipt" onclick="printMoneyReceipt('${p.id}')"><i class="fa-solid fa-print"></i></button>
            <button class="icon-action-btn text-danger" title="Delete" onclick="deletePaymentRecord('${p.id}')"><i class="fa-solid fa-trash-can"></i></button>
          </div>
        </div>
      `).join('')}
    </div>
  `;
}

// Attendance Increment / Decrement
function updateStudentAttendance(studentId, delta) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;
  if (!student.attendance) student.attendance = {};
  const curMonthKey = new Date().toISOString().substring(0, 7);
  const cur = student.attendance[curMonthKey] || 0;
  student.attendance[curMonthKey] = Math.max(0, cur + delta);
  state.save();
  renderStudentDetail(studentId);
}

// ==================== ONE-TAP DUE REMINDER SMS ====================
function sendDueReminderSms(studentId) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;
  const due = state.getStudentDue(student);

  if (!student.fatherPhone) {
    alert(state.t('no_phone_msg'));
    return;
  }
  if (due <= 0) {
    alert(state.t('no_due_msg'));
    return;
  }

  const isBn = state.settings.lang === 'bn';
  const text = isBn
    ? `সম্মানিত অভিভাবক, আপনার সন্তান ${student.name} (শ্রেণি: ${student.className}, রোল: ${student.rollNumber})-এর টিউশন ফি বাবদ ৳${due.toLocaleString('en-IN')} বকেয়া রয়েছে। অনুগ্রহ করে দ্রুত পরিশোধ করুন। ধন্যবাদ - ABS Hisab Manager`
    : `Dear Parent, Tuition fee of Tk ${due.toLocaleString('en-IN')} is due for your child ${student.name} (Class: ${student.className}, Roll: ${student.rollNumber}). Kindly arrange payment. Thank you - ABS Hisab Manager`;

  const smsUrl = `sms:${student.fatherPhone}?body=${encodeURIComponent(text)}`;
  window.open(smsUrl, '_blank');
}

function callFatherPhone(phone) {
  if (!phone) return alert(state.t('no_phone_msg'));
  window.location.href = `tel:${phone}`;
}

function messageFatherPhone(phone) {
  if (!phone) return alert(state.t('no_phone_msg'));
  window.location.href = `sms:${phone}`;
}

// ==================== ADD / EDIT STUDENT ====================
function openAddStudentModal(studentId = null) {
  const form = document.getElementById('studentForm');
  form.reset();
  document.getElementById('studentFormId').value = '';
  document.getElementById('studentModalTitle').innerText = state.t('add_student');
  document.getElementById('fmAdmissionDate').value = new Date().toISOString().split('T')[0];

  if (studentId) {
    const s = state.students.find(x => x.id === studentId);
    if (s) {
      document.getElementById('studentFormId').value = s.id;
      document.getElementById('studentModalTitle').innerText = state.t('edit_student');
      document.getElementById('fmStudentName').value = s.name || '';
      document.getElementById('fmStudentClass').value = s.className || 'Nine';
      document.getElementById('fmStudentRoll').value = s.rollNumber || '';
      document.getElementById('fmStudentSection').value = s.section || '';
      document.getElementById('fmStudentFee').value = s.monthlyFee || '';
      document.getElementById('fmFatherName').value = s.fatherName || '';
      document.getElementById('fmFatherPhone').value = s.fatherPhone || '';
      document.getElementById('fmStudentAddress').value = s.address || '';
      document.getElementById('fmAdmissionDate').value = s.admissionDate || '';
      document.getElementById('fmStudentNotes').value = s.notes || '';
    }
  }

  openModal('studentModal');
}

function handleSaveStudent(e) {
  e.preventDefault();
  const id = document.getElementById('studentFormId').value;
  const name = document.getElementById('fmStudentName').value.trim();
  const className = document.getElementById('fmStudentClass').value;
  const rollNumber = document.getElementById('fmStudentRoll').value.trim();
  const section = document.getElementById('fmStudentSection').value.trim();
  const monthlyFee = Number(document.getElementById('fmStudentFee').value);
  const fatherName = document.getElementById('fmFatherName').value.trim();
  const fatherPhone = document.getElementById('fmFatherPhone').value.trim();
  const address = document.getElementById('fmStudentAddress').value.trim();
  const admissionDate = document.getElementById('fmAdmissionDate').value;
  const notes = document.getElementById('fmStudentNotes').value.trim();

  if (id) {
    const index = state.students.findIndex(s => s.id === id);
    if (index !== -1) {
      state.students[index] = {
        ...state.students[index],
        name, className, rollNumber, section, monthlyFee, fatherName, fatherPhone, address, admissionDate, notes
      };
    }
  } else {
    const newStudent = {
      id: `std-${Date.now()}`,
      name, className, rollNumber, section, monthlyFee, fatherName, fatherPhone, address, admissionDate, notes,
      attendance: {}
    };
    state.students.unshift(newStudent);
  }

  state.save();
  closeModal('studentModal');
  renderDashboard();
  renderStudentsList();
  if (id && state.selectedStudentId === id) renderStudentDetail(id);
}

function editCurrentStudent() {
  if (state.selectedStudentId) {
    closeModal('studentDetailModal');
    openAddStudentModal(state.selectedStudentId);
  }
}

function deleteCurrentStudent() {
  if (!state.selectedStudentId) return;
  if (!confirm(state.t('delete_confirm'))) return;

  const id = state.selectedStudentId;
  state.students = state.students.filter(s => s.id !== id);
  state.payments = state.payments.filter(p => p.studentId !== id);
  state.transactions = state.transactions.filter(t => t.linkedStudentId !== id && t.id !== id);

  state.save();
  closeModal('studentDetailModal');
  renderDashboard();
  renderStudentsList();
}

// ==================== COLLECT PAYMENT ====================
function openStudentPickerModal() {
  renderStudentPickerList();
  openModal('studentPickerModal');
}

function renderStudentPickerList() {
  const list = document.getElementById('pickerStudentList');
  const q = (document.getElementById('pickerSearchInput')?.value || '').trim().toLowerCase();
  const filtered = state.students.filter(s => !q || s.name.toLowerCase().includes(q) || (s.rollNumber || '').includes(q));

  if (filtered.length === 0) {
    list.innerHTML = `<div style="text-align:center; padding:16px; color:var(--text-muted);">কোনো শিক্ষার্থী পাওয়া যায়নি</div>`;
    return;
  }

  list.innerHTML = filtered.map(s => {
    const due = state.getStudentDue(s);
    return `
      <div style="background:var(--background); padding:12px; border-radius:var(--radius-md); margin-bottom:8px; display:flex; justify-content:space-between; align-items:center; cursor:pointer;" onclick="selectStudentForPayment('${s.id}')">
        <div>
          <strong>${s.name}</strong>
          <div style="font-size:12px; color:var(--text-muted);">${s.className} · Roll ${s.rollNumber}</div>
        </div>
        <div style="text-align:right;">
          <div style="font-weight:700;">৳ ${s.monthlyFee}</div>
          ${due > 0 ? `<span class="badge-pill badge-due">বাকি: ৳ ${due}</span>` : ''}
        </div>
      </div>
    `;
  }).join('');
}

function selectStudentForPayment(studentId) {
  closeModal('studentPickerModal');
  openCollectPaymentForStudent(studentId);
}

function openCollectPaymentForStudent(studentId) {
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  document.getElementById('paymentForm').reset();
  document.getElementById('pmStudentId').value = student.id;
  document.getElementById('pmAmount').value = student.monthlyFee;
  document.getElementById('pmDate').value = new Date().toISOString().split('T')[0];
  document.getElementById('pmMonth').value = new Date().toISOString().substring(0, 7);
  document.getElementById('pmGiveReceipt').checked = true;

  const due = state.getStudentDue(student);
  document.getElementById('pmStudentBadge').innerHTML = `
    <div style="display:flex; justify-content:space-between; align-items:center;">
      <div>
        <strong>${student.name}</strong> (${student.className} - Roll ${student.rollNumber})
      </div>
      <span class="badge-pill ${due > 0 ? 'badge-due' : 'badge-paid'}">বর্তমান বাকি: ৳ ${due.toLocaleString('en-IN')}</span>
    </div>
  `;

  openModal('collectPaymentModal');
}

function handleSavePayment(e) {
  e.preventDefault();
  const studentId = document.getElementById('pmStudentId').value;
  const student = state.students.find(s => s.id === studentId);
  if (!student) return;

  const amount = Number(document.getElementById('pmAmount').value);
  const method = document.getElementById('pmMethod').value;
  const forMonth = document.getElementById('pmMonth').value;
  const paymentDate = document.getElementById('pmDate').value;
  const note = document.getElementById('pmNote').value.trim();
  const giveReceipt = document.getElementById('pmGiveReceipt').checked;
  const receiptNo = state.getNextReceiptNo();

  const paymentId = `pay-${Date.now()}`;
  const payment = {
    id: paymentId,
    studentId,
    amount,
    method,
    paymentDate,
    forMonth,
    note,
    receiptNo,
    receiptGiven: giveReceipt
  };
  state.payments.unshift(payment);

  // Auto-sync into Transactions as Income
  const txnNote = `Tuition fee - ${student.name} (${receiptNo})${note ? ' · ' + note : ''}`;
  const txn = {
    id: paymentId,
    amount,
    type: 'income',
    category: 'Tuition',
    date: paymentDate,
    note: txnNote,
    linkedStudentId: studentId
  };
  state.transactions.unshift(txn);

  state.save();
  closeModal('collectPaymentModal');

  renderDashboard();
  renderStudentsList();
  renderTransactionsList();
  if (state.selectedStudentId === studentId) renderStudentDetail(studentId);

  if (giveReceipt) {
    printMoneyReceipt(paymentId);
  }
}

function deletePaymentRecord(paymentId) {
  if (!confirm(state.t('delete_confirm'))) return;
  state.payments = state.payments.filter(p => p.id !== paymentId);
  state.transactions = state.transactions.filter(t => t.id !== paymentId);
  state.save();

  renderDashboard();
  renderTransactionsList();
  if (state.selectedStudentId) renderStudentDetail(state.selectedStudentId);
}

// ==================== TRANSACTIONS VIEW & ACTIONS ====================
function setTxnTypeFilter(type) {
  state.txnTypeFilter = type;
  document.querySelectorAll('#txnFilterChips .chip').forEach(c => {
    c.classList.toggle('active', c.getAttribute('data-type') === type);
  });
  renderTransactionsList();
}

function renderTransactionsList() {
  const listEl = document.getElementById('fullTxnList');
  if (!listEl) return;

  const filtered = state.transactions.filter(t => {
    if (state.txnTypeFilter === 'all') return true;
    return t.type === state.txnTypeFilter;
  }).sort((a, b) => new Date(b.date) - new Date(a.date));

  if (filtered.length === 0) {
    listEl.innerHTML = `<div style="text-align:center; padding:30px; color:var(--text-muted);">কোনো লেনদেন পাওয়া যায়নি</div>`;
    return;
  }

  listEl.innerHTML = filtered.map(t => renderTxnCardHtml(t)).join('');
}

function openAddTransactionModal(type = 'expense') {
  document.getElementById('txnForm').reset();
  document.getElementById('txnFormId').value = '';
  document.getElementById('txnDate').value = new Date().toISOString().split('T')[0];
  setFormTxnType(type);
  openModal('transactionModal');
}

function setFormTxnType(type) {
  document.getElementById('txnFormType').value = type;
  document.getElementById('txnTypeIncomeBtn').classList.toggle('active', type === 'income');
  document.getElementById('txnTypeExpenseBtn').classList.toggle('active', type === 'expense');

  const catSelect = document.getElementById('txnCategory');
  const cats = state.categories[type] || [];
  catSelect.innerHTML = cats.map(c => `<option value="${c}">${c}</option>`).join('');

  const submitBtn = document.getElementById('btnSaveTxnSubmit');
  submitBtn.className = `submit-btn ${type === 'income' ? 'btn-income' : 'btn-expense'}`;
}

function handleSaveTransaction(e) {
  e.preventDefault();
  const id = document.getElementById('txnFormId').value;
  const type = document.getElementById('txnFormType').value;
  const amount = Number(document.getElementById('txnAmount').value);
  const category = document.getElementById('txnCategory').value;
  const date = document.getElementById('txnDate').value;
  const note = document.getElementById('txnNote').value.trim();

  if (id) {
    const idx = state.transactions.findIndex(t => t.id === id);
    if (idx !== -1) {
      state.transactions[idx] = { ...state.transactions[idx], type, amount, category, date, note };
    }
  } else {
    state.transactions.unshift({
      id: `txn-${Date.now()}`,
      type, amount, category, date, note
    });
  }

  state.save();
  closeModal('transactionModal');
  renderDashboard();
  renderTransactionsList();
}

function deleteTransaction(txnId) {
  if (!confirm(state.t('delete_confirm'))) return;
  state.transactions = state.transactions.filter(t => t.id !== txnId);
  state.payments = state.payments.filter(p => p.id !== txnId); // Sync if linked
  state.save();
  renderDashboard();
  renderTransactionsList();
  if (state.selectedStudentId) renderStudentDetail(state.selectedStudentId);
}

// ==================== FINANCIAL REPORTS ====================
function openReportModal() {
  renderReportContent();
  openModal('reportModal');
}

function renderReportContent() {
  const body = document.getElementById('reportBody');
  const anchor = state.reportAnchorDate;
  const period = state.currentReportPeriod;

  // Filter transactions in range
  const curMonth = anchor.getMonth();
  const curYear = anchor.getFullYear();
  const txns = state.transactions.filter(t => {
    const d = new Date(t.date);
    if (period === 'monthly') return d.getMonth() === curMonth && d.getFullYear() === curYear;
    if (period === 'yearly') return d.getFullYear() === curYear;
    return true;
  });

  const income = txns.filter(t => t.type === 'income').reduce((s, t) => s + Number(t.amount), 0);
  const expense = txns.filter(t => t.type === 'expense').reduce((s, t) => s + Number(t.amount), 0);
  const net = income - expense;

  const monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  const label = period === 'monthly' ? `${monthNames[curMonth]} ${curYear}` : `${curYear}`;

  body.innerHTML = `
    <div style="display:flex; justify-content:space-between; align-items:center; background:var(--background); padding:12px; border-radius:var(--radius-md);">
      <button class="icon-action-btn" onclick="shiftReportPeriod(-1)"><i class="fa-solid fa-chevron-left"></i></button>
      <strong>${label}</strong>
      <button class="icon-action-btn" onclick="shiftReportPeriod(1)"><i class="fa-solid fa-chevron-right"></i></button>
    </div>

    <div class="stats-grid mt-3">
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট আয়</div>
          <div class="stat-value" style="color:var(--income)">৳ ${income.toLocaleString('en-IN')}</div>
        </div>
      </div>
      <div class="stat-card">
        <div class="stat-info">
          <div class="stat-label">মোট ব্যয়</div>
          <div class="stat-value" style="color:var(--expense)">৳ ${expense.toLocaleString('en-IN')}</div>
        </div>
      </div>
    </div>

    <div class="balance-card mt-3" style="padding:18px;">
      <div class="balance-sub">নিট লাভ / ক্ষতি</div>
      <div class="balance-amount" style="font-size:26px;">৳ ${net.toLocaleString('en-IN')}</div>
    </div>

    <div class="box-title mt-4">লেনদেনের তালিকা (${txns.length})</div>
    <div class="transactions-list mt-2">
      ${txns.map(t => renderTxnCardHtml(t)).join('')}
    </div>
  `;
}

function shiftReportPeriod(dir) {
  state.reportAnchorDate = new Date(state.reportAnchorDate.getFullYear(), state.reportAnchorDate.getMonth() + dir, 1);
  renderReportContent();
}

// ==================== PRINT MONEY RECEIPT (A5) ====================
function printMoneyReceipt(paymentId) {
  const payment = state.payments.find(p => p.id === paymentId);
  if (!payment) return;
  const student = state.students.find(s => s.id === payment.studentId) || { name: 'Student', className: '—', rollNumber: '—', section: '—' };

  const printArea = document.getElementById('printArea');
  printArea.innerHTML = `
    <div style="font-family:Arial,sans-serif; max-width:600px; margin:0 auto; padding:30px; border:2px solid #4f46e5; border-radius:12px;">
      <div style="text-align:center; margin-bottom:20px;">
        <h2 style="color:#4f46e5; margin:0;">ABS Hisab Manager</h2>
        <h4 style="margin:4px 0 0 0; color:#475569;">MONEY RECEIPT (মানি রিসিট)</h4>
      </div>
      <hr style="border:0; border-top:1px solid #cbd5e1; margin:16px 0;">
      <table style="width:100%; font-size:14px; line-height:2;">
        <tr><td><strong>Receipt No:</strong></td><td style="text-align:right;">${payment.receiptNo}</td></tr>
        <tr><td><strong>Payment Date:</strong></td><td style="text-align:right;">${payment.paymentDate}</td></tr>
        <tr><td><strong>Student Name:</strong></td><td style="text-align:right;">${student.name}</td></tr>
        <tr><td><strong>Class & Roll:</strong></td><td style="text-align:right;">${student.className} · Roll ${student.rollNumber} (${student.section || '—'})</td></tr>
        <tr><td><strong>For Month:</strong></td><td style="text-align:right;">${payment.forMonth}</td></tr>
        <tr><td><strong>Payment Method:</strong></td><td style="text-align:right;">${payment.method}</td></tr>
        ${payment.note ? `<tr><td><strong>Note:</strong></td><td style="text-align:right;">${payment.note}</td></tr>` : ''}
      </table>
      <hr style="border:0; border-top:2px solid #4f46e5; margin:16px 0;">
      <div style="display:flex; justify-content:space-between; font-size:18px; font-weight:bold; color:#10b981; padding:8px 0;">
        <span>Amount Paid (পরিশোধিত অর্থ):</span>
        <span>Tk ${Number(payment.amount).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</span>
      </div>
      <div style="margin-top:50px; display:flex; justify-content:space-between; font-size:12px; color:#64748b;">
        <span>Thank you for your payment!</span>
        <span style="border-top:1px solid #334155; padding-top:4px;">Tutor / Authority Signature</span>
      </div>
    </div>
  `;

  window.print();
}

// ==================== PRINT FULL STUDENT STATEMENT (A4) ====================
function printStudentFullStatement() {
  if (!state.selectedStudentId) return;
  const s = state.students.find(x => x.id === state.selectedStudentId);
  if (!s) return;

  const expected = state.getTotalExpected(s);
  const paid = state.getTotalPaid(s.id);
  const due = state.getStudentDue(s);
  const advance = state.getStudentAdvance(s);
  const payments = state.payments.filter(p => p.studentId === s.id).sort((a, b) => new Date(a.paymentDate) - new Date(b.paymentDate));
  const totalClasses = Object.values(s.attendance || {}).reduce((a, b) => a + b, 0);

  const printArea = document.getElementById('printArea');
  printArea.innerHTML = `
    <div style="font-family:Arial,sans-serif; max-width:800px; margin:0 auto; padding:30px; color:#0f172a;">
      <div style="text-align:center; margin-bottom:18px;">
        <h1 style="color:#4f46e5; margin:0;">ABS Hisab Manager</h1>
        <h3 style="margin:4px 0 0 0; color:#475569;">STUDENT FINANCIAL STATEMENT & LEDGER</h3>
      </div>
      <hr style="border:0; border-top:1px solid #cbd5e1; margin:16px 0;">

      <div style="display:flex; justify-content:space-between; font-size:13px; line-height:1.8;">
        <div>
          <div><strong>Student:</strong> ${s.name}</div>
          <div><strong>Class:</strong> ${s.className}  |  <strong>Roll:</strong> ${s.rollNumber}  |  <strong>Sec:</strong> ${s.section || '—'}</div>
          <div><strong>Admission Date:</strong> ${s.admissionDate || '—'}</div>
          <div><strong>Address:</strong> ${s.address || '—'}</div>
        </div>
        <div style="text-align:right;">
          <div><strong>Monthly Fee:</strong> Tk ${Number(s.monthlyFee).toLocaleString('en-IN')}</div>
          <div><strong>Father's Name:</strong> ${s.fatherName || '—'}</div>
          <div><strong>Father's Mobile:</strong> ${s.fatherPhone || '—'}</div>
          <div><strong>Total Classes Attended:</strong> ${totalClasses}</div>
        </div>
      </div>

      <!-- Financial Overview Box -->
      <div style="background:#f1f5f9; padding:14px; border-radius:8px; margin:20px 0; display:flex; justify-content:space-around; text-align:center;">
        <div><div style="font-size:11px; color:#64748b;">Total Expected</div><strong style="font-size:15px;">Tk ${expected.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Total Paid</div><strong style="font-size:15px; color:#10b981;">Tk ${paid.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Current Due</div><strong style="font-size:15px; color:#ef4444;">Tk ${due.toLocaleString('en-IN')}</strong></div>
        <div><div style="font-size:11px; color:#64748b;">Advance</div><strong style="font-size:15px; color:#06b6d4;">Tk ${advance.toLocaleString('en-IN')}</strong></div>
      </div>

      <!-- Payments Table -->
      <h4 style="margin:20px 0 10px 0;">Itemized Payment Ledger</h4>
      <table style="width:100%; border-collapse:collapse; font-size:12px; text-align:left;">
        <thead>
          <tr style="background:#4f46e5; color:white;">
            <th style="padding:8px;">Receipt No</th>
            <th style="padding:8px;">Date</th>
            <th style="padding:8px;">For Month</th>
            <th style="padding:8px;">Method</th>
            <th style="padding:8px;">Note</th>
            <th style="padding:8px; text-align:right;">Amount (Tk)</th>
          </tr>
        </thead>
        <tbody>
          ${payments.map((p, i) => `
            <tr style="border-bottom:1px solid #e2e8f0; background:${i % 2 === 0 ? '#ffffff' : '#f8fafc'};">
              <td style="padding:8px;">${p.receiptNo}</td>
              <td style="padding:8px;">${p.paymentDate}</td>
              <td style="padding:8px;">${p.forMonth}</td>
              <td style="padding:8px;">${p.method}</td>
              <td style="padding:8px;">${p.note || '—'}</td>
              <td style="padding:8px; text-align:right; font-weight:bold;">${Number(p.amount).toLocaleString('en-IN')}</td>
            </tr>
          `).join('')}
        </tbody>
      </table>

      <div style="margin-top:60px; display:flex; justify-content:space-between; font-size:11px; color:#64748b;">
        <span>Generated on: ${new Date().toLocaleDateString()}</span>
        <span style="border-top:1px solid #334155; padding-top:4px;">Tutor / Authority Signature</span>
      </div>
    </div>
  `;

  window.print();
}

function printFinancialReportPdf() {
  window.print();
}

// ==================== CATEGORIES MANAGEMENT ====================
function openCategoriesModal() {
  switchCategoryTab('expense');
  openModal('categoriesModal');
}

function switchCategoryTab(type) {
  document.getElementById('catTabExpenseBtn').classList.toggle('active', type === 'expense');
  document.getElementById('catTabIncomeBtn').classList.toggle('active', type === 'income');
  renderCategoriesList(type);
}

function renderCategoriesList(type = 'expense') {
  const container = document.getElementById('categoriesListContainer');
  if (!container) return;
  const list = state.categories[type] || [];

  container.innerHTML = list.map(c => `
    <div style="background:var(--background); padding:10px 14px; border-radius:var(--radius-md); display:flex; justify-content:space-between; align-items:center; margin-bottom:6px;">
      <span style="font-weight:600; font-size:13px;">${c}</span>
      ${list.length > 1 ? `<button class="icon-action-btn text-danger" onclick="deleteCategory('${type}', '${c}')"><i class="fa-solid fa-trash-can"></i></button>` : ''}
    </div>
  `).join('');
}

function addNewCategory() {
  const input = document.getElementById('newCategoryInput');
  const name = (input.value || '').trim();
  if (!name) return;
  const isIncome = document.getElementById('catTabIncomeBtn').classList.contains('active');
  const type = isIncome ? 'income' : 'expense';

  if (!state.categories[type].includes(name)) {
    state.categories[type].push(name);
    state.save();
    input.value = '';
    renderCategoriesList(type);
  }
}

function deleteCategory(type, name) {
  state.categories[type] = state.categories[type].filter(c => c !== name);
  state.save();
  renderCategoriesList(type);
}

// ==================== PIN LOCK & SECURITY ====================
function checkPinLock() {
  if (state.settings.pin && state.settings.pin.length === 4) {
    document.getElementById('pinLockOverlay').classList.add('show');
    state.enteredPin = '';
    updatePinDots();
  } else {
    document.getElementById('pinLockOverlay').classList.remove('show');
  }
}

function enterPinDigit(d) {
  if (state.enteredPin.length < 4) {
    state.enteredPin += d;
    updatePinDots();
    if (state.enteredPin.length === 4) {
      setTimeout(() => {
        if (state.enteredPin === state.settings.pin) {
          document.getElementById('pinLockOverlay').classList.remove('show');
          document.getElementById('pinErrorText').innerText = '';
        } else {
          document.getElementById('pinErrorText').innerText = 'ভুল পিন কোড (Incorrect PIN)';
          state.enteredPin = '';
          updatePinDots();
        }
      }, 100);
    }
  }
}

function deletePinDigit() {
  state.enteredPin = state.enteredPin.slice(0, -1);
  updatePinDots();
}

function updatePinDots() {
  const dots = document.querySelectorAll('#pinDotsRow .pin-dot');
  dots.forEach((dot, i) => {
    dot.classList.toggle('filled', i < state.enteredPin.length);
  });
}

function simulateBiometric() {
  // Biometric Unlock Simulation
  document.getElementById('pinLockOverlay').classList.remove('show');
}

function openPinModal() {
  document.getElementById('newPinInput').value = '';
  document.getElementById('confirmPinInput').value = '';
  document.getElementById('btnRemovePin').style.display = state.settings.pin ? 'block' : 'none';
  openModal('pinSettingModal');
}

function saveNewPin() {
  const p1 = document.getElementById('newPinInput').value;
  const p2 = document.getElementById('confirmPinInput').value;
  if (p1.length !== 4) return alert('পিন অবশ্যই ৪ ডিজিটের হতে হবে');
  if (p1 !== p2) return alert('পিন দুটি মেলেনি');

  state.settings.pin = p1;
  state.save();
  closeModal('pinSettingModal');
  alert('পিন সফলভাবে সংরক্ষিত হয়েছে');
}

function removePinSecurity() {
  state.settings.pin = '';
  state.save();
  closeModal('pinSettingModal');
  alert('পিন লক নিষ্ক্রিয় করা হয়েছে');
}

// ==================== DATA BACKUP (JSON EXPORT/IMPORT) ====================
function exportDataBackup() {
  const data = {
    version: 2,
    exportedAt: new Date().toISOString(),
    students: state.students,
    payments: state.payments,
    transactions: state.transactions,
    categories: state.categories
  };

  const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `abs_hisab_backup_${Date.now()}.json`;
  a.click();
  URL.revokeObjectURL(url);
}

function triggerImportBackup() {
  document.getElementById('importFileInput').click();
}

function handleImportFile(e) {
  const file = e.target.files[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = (evt) => {
    try {
      const data = JSON.parse(evt.target.result);
      if (data.students) state.students = data.students;
      if (data.payments) state.payments = data.payments;
      if (data.transactions) state.transactions = data.transactions;
      if (data.categories) state.categories = data.categories;
      state.save();
      alert('ডাটা ব্যাকআপ সফলভাবে রিস্টোর হয়েছে!');
      renderDashboard();
      renderStudentsList();
      renderTransactionsList();
    } catch (err) {
      alert('ভুল ফাইল ফরম্যাট!');
    }
  };
  reader.readAsText(file);
}

function confirmClearAllData() {
  if (confirm('আপনি কি নিশ্চিত যে সকল ডাটা মুছে ফেলতে চান? এটি আর ফেরানো যাবে না।')) {
    state.students = [];
    state.payments = [];
    state.transactions = [];
    state.save();
    renderDashboard();
    renderStudentsList();
    renderTransactionsList();
    alert('সকল ডাটা মুছে ফেলা হয়েছে');
  }
}

// ==================== MODAL HELPERS ====================
function openModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.add('show');
}

function closeModal(id) {
  const el = document.getElementById(id);
  if (el) el.classList.remove('show');
}
